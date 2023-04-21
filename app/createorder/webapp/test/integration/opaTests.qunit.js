sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/mhp/create/order/createorder/test/integration/FirstJourney',
		'com/mhp/create/order/createorder/test/integration/pages/OrdersObjectPage',
		'com/mhp/create/order/createorder/test/integration/pages/OrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersObjectPage, OrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/mhp/create/order/createorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersObjectPage: OrdersObjectPage,
					onTheOrderItemsObjectPage: OrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);