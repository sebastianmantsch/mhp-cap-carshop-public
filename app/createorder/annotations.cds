using CatalogService as service from '../../srv/catalog-service';



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
annotate service.Customer with @(
        title                  : '{i18n>Customer}',
   Communication.Contact : {
    $Type : 'Communication.ContactType',
    adr : [
        {
            $Type : 'Communication.AddressType',
            type : #work,
            label: '{i18n>Address}',
        country : country,
        street : street,
        building : housenumber,
        code : postalCode,
        locality : city
        }
    ],
    email : [
        {
            $Type : 'Communication.EmailAddressType',
            type : #work,
            address : email
        }
    ],
    fn : {
        $edmJson : {
            $Apply : [
                {$Path: 'firstName'},
                ' ',
                {$Path: 'lastName'},    
            ],
            $Function : 'odata.concat',
        },
    },
    tel : [
        {
            $Type : 'Communication.PhoneNumberType',
            type : #preferred,
            uri : phone
        }
    ]
    
});



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
    ],
     UI.FieldGroup #customerData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: Customer_ID
            },
             {
                $Type  : 'UI.DataFieldForAnnotation',
                Target : 'Customer/@Communication.Contact',
                Label  : 'Customer'
            },
            {
                $Type : 'UI.DataField',
                Value : Customer.firstName,
            },
            {
                $Type : 'UI.DataField',
                Value : Customer.lastName,
            }
        ],
    }
);



