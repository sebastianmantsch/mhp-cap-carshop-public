using AdminService as service from '../../srv/admin-service';

annotate service.Cars with {
    price @Common.FieldControl: #ReadOnly;
};


annotate service.Orders with @(UI : { 
        SelectionFields: [ OrderNo ],
        
        LineItem: [
            {Value: OrderNo, Label: 'Order Number'},
            {Value: price, Label: 'Price'},
            {Value: currency.symbol, Label:' '},
        ],
        HeaderInfo: {
            TypeName: 'Order',
            TypeNamePlural: 'Orders'
        },
        
		HeaderFacets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Description}', Target: '@UI.FieldGroup#Descr'},
		],
        
		FieldGroup#Descr: {
			Data: [
				{Value: OrderNo},
			]
		},
		FieldGroup#Price: {
			Data: [
				{Value: currency_code, Label: '{i18n>Currency}'},
			]
		},        
} );

////////////////////////////////////////////////////////////////////////////
//
//	Common
//
annotate service.OrderItems with {
	car @(
		Common: {
			Text: car.model,
			FieldControl: #Mandatory
		},
		ValueList.entity:'Cars'
       
	);
	amount @(
		Common.FieldControl: #Mandatory
	);
}

annotate service.Orders with {
   //  UI:  
      ID  @(
        Core.Computed,
        UI.HiddenFilter
    ); 
};




annotate service.Orders with @(
    UI.FieldGroup #carInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Items.car.model,
            },
        ],
    }
);
annotate service.Orders with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Details}',
            Target : '@UI.FieldGroup#Price',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'CarInfo',
            ID : 'carinfo',
            Target : '@UI.FieldGroup#carInfo',
        },
    ]
);
