sap.ui.define([],
function (){
    "use strict";
    return {
        createOrder: function(oEvent) {
      
            //Create new order with reference to Car and navigate to create order application prefilled
          
            var oBindingContext = this.getBindingContext();
            var oCar = oBindingContext.getObject();
            var sCarID = oCar.ID;

            var sOutbound = "com-mhp-create-order-createorder-inbound";
            var mParameters = {Car: sCarID}
            if(sap.ushell && sap.ushell.Container && sap.ushell.Container.getService){
                this.getIntentBasedNavigation().navigateOutbound(sOutbound, mParameters)
                return true;
            }
          
            return false;


        }
    };
});
