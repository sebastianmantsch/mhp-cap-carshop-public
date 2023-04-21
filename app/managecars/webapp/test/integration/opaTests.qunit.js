sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/mhp/managecars/test/integration/FirstJourney',
		'com/mhp/managecars/test/integration/pages/CarsList',
		'com/mhp/managecars/test/integration/pages/CarsObjectPage'
    ],
    function(JourneyRunner, opaJourney, CarsList, CarsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/mhp/managecars') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCarsList: CarsList,
					onTheCarsObjectPage: CarsObjectPage
                }
            },
            opaJourney.run
        );
    }
);