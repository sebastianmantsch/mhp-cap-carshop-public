sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/mhp/createorder/test/integration/FirstJourney',
		'com/mhp/createorder/test/integration/pages/OrdersList',
		'com/mhp/createorder/test/integration/pages/OrdersObjectPage',
		'com/mhp/createorder/test/integration/pages/OrderItemsObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage, OrderItemsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/mhp/createorder') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage,
					onTheOrderItemsObjectPage: OrderItemsObjectPage
                }
            },
            opaJourney.run
        );
    }
);