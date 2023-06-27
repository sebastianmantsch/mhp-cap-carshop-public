sap.ui.define([
    "./BaseController",
    "../model/formatter"
], function (BaseController, formatter) {
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