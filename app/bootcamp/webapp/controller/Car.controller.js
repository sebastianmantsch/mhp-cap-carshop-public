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
        },

        /* =========================================================== */
        /* event handlers                                              */
        /* =========================================================== */

        /* =========================================================== */
        /* begin: internal methods                                     */
        /* =========================================================== */

    });

});