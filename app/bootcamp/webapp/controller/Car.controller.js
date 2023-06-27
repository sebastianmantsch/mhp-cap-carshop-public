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

            // Set the layout to three Column layout
            this.getModel("appView").setProperty("/layout", "ThreeColumnsMidExpanded");

        }

    });

});