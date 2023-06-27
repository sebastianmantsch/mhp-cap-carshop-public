sap.ui.define([
    "./BaseController",
    "../model/formatter",
    "sap/m/MessageToast"
    
], function (BaseController, formatter, MessageToast) {
    "use strict";

    return BaseController.extend("phag.demo.bootcamp.controller.Detail", {

        formatter: formatter,

        /* =========================================================== */
        /* lifecycle methods                                           */
        /* =========================================================== */

        onInit: function () {
            // Register to react on routing events for route "car" as configured in the manifest
            this.getRouter().getRoute("car").attachPatternMatched(this._onRouteMatched, this);

        },

        /* =========================================================== */
        /* event handlers                                              */
        /* =========================================================== */

        onSaveCar: function () {
            const oModel = this.getModel();

            // Check for changes
            if (oModel.hasPendingChanges()) {

                // Save the data changed in the OData model
                oModel.submitChanges({
                    success: () => {
                        // Show success message in a Toast
                        MessageToast.show("Car data saved");
                        // Navigate to the previous view after saving
                        this.getRouter().navTo("object", {
                            objectId: this.sManufacturerID
                        });
                    },
                    error: () => {
                        // Display error and do nothing more
                        MessageToast.show("Error while saving!");
                    }
                });
            } else {
                // No changes message
                MessageToast.show("No changes");
                // Navigate to the previous view after message
                this.getRouter().navTo("object", {
                    objectId: this.sManufacturerID
                });
            }
            
        },

        /* =========================================================== */
        /* begin: internal methods                                     */
        /* =========================================================== */

        _onRouteMatched: function (oEvent) {

            // Read routing arguments for later use (e.g. back navigation)
	        this.sManufacturerID = oEvent.getParameter("arguments").objectId;
	        this.sCarID = oEvent.getParameter("arguments").carId;

	        // Set the layout to three Column layout
	        this.getModel("appView").setProperty("/layout", "ThreeColumnsMidExpanded"); 

            // After the metamodel was loaded (Promise) create the binding path
            this.getModel().metadataLoaded().then(() => {
                const sCarPath = this.getModel().createKey("Cars", {
                    ID: this.sCarID
                }); 

                // Bind this car to the view
                this._bindView("/" + sCarPath);
            });

        },

        _bindView: function (sObjectPath) {
            this.getView().bindElement({
                path: sObjectPath
            });
        },
        

    });

});