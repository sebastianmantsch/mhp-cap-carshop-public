sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        onCreateCustomer: function(oEvent) {
            MessageToast.show("Custom handler invoked.");
        }
    };
});
