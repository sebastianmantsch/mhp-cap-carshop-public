using CatalogService as service from '../../srv/catalog-service';


annotate service.Orders with @(
    UI.FieldGroup #customerData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : customer.firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.lastName,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.street,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.housenumber,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.postalCode,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.city,
            },
            {
                $Type : 'UI.DataField',
                Value : customer.country,
            },
        ],
    }
);


annotate service.OrderItems with @(
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : car_ID,
            Label : '{i18n>CarID}'
        },
        {
            $Type : 'UI.DataField',
            Value : amount,
        },
        {
            $Type : 'UI.DataFieldForIntentBasedNavigation',
            SemanticObject : 'catalog',
            Action : 'browse',
            Label : 'Browse Car'
        },
    ],
    
){
	car @(
		Common: {
			Text: car.model,
			FieldControl: #Mandatory
		},
		ValueList.entity:'Cars',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Cars',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : car_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'model',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'color',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'price',
                
                },
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : car.manufacturer,
                    ValueListProperty : 'manufacturer',
                }
            ],
        },
	);
	amount @(
		Common.FieldControl: #Mandatory
	);
}
annotate service.Orders with @(
    UI.Facets : [
   
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Customer',
            ID : 'customer',
            Target : '@UI.FieldGroup#customerData',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'Items/@UI.LineItem',
            ID: 'orderItems',
            Label: 'Order Items'
        },
    ]
);
