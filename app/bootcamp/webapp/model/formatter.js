sap.ui.define([], function () {
    "use strict";

    return {
        /**
         * Rounds the currency value to 2 digits
         *
         * @public
         * @param {string} sValue value to be formatted
         * @returns {string} formatted currency value with 2 digits
         */
        currencyValue : function (sValue) {
            if (!sValue) {
                return "";
            }

            return parseFloat(sValue).toFixed(2);
        },

        formatStockState: function (sValue) {
            if (sValue > 10) {
                return sap.ui.core.ValueState.Success;
            } else if (sValue === 0) {
                return sap.ui.core.ValueState.Error;
            } else {
                return sap.ui.core.ValueState.Warning;
            }
        }
    };
});