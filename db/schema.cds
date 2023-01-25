namespace mhp.capire.carshop;

using
{
    Currency,
    managed,
    sap,
    cuid
}
from '@sap/cds/common';

entity Cars : managed
{
    key ID : Integer @title: '{i18n>CarID}';
    descr : localized String(1111)
        @title : '{i18n>Description}';
    model : String(100)
        @title : '{i18n>Model}'
        @Common.ValueListWithFixedValues
        @Common.ValueList : 
        {
            CollectionPath : 'Cars',
            DistinctValuesSupported : true,
            Parameters :
            [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    ValueListProperty : 'model',
                    LocalDataProperty : model
                }
            ]
        };
    manufacturer : Association to one Manufacturers;
    price : Decimal
        @title : '{i18n>Price}';
    currency : Currency;
    stock : Integer;
    engineType : EngineType;
    enginePowerKw : Integer;
    color : String(30) @title: '[i18n>Color}';
    image : LargeBinary
        @Core.MediaType : 'image/png';
}

annotate Cars with {
    title @( Common: { Label: '{i18n>Title}'});
}

annotate Cars with @(
	UI: {
        HeaderInfo: {
            TypeName: '{i18n>Car}',
            TypeNamePlural: '{i18n>Cars}',
            Description: {Value: model},
            Image: image
        
        },
		HeaderFacets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Description}', Target: '@UI.FieldGroup#Descr'},
		],
		Facets: [
			{$Type: 'UI.ReferenceFacet', Label: '{i18n>Details}', Target: '@UI.FieldGroup#Price'},
		],
		FieldGroup#Descr: {
			Data: [
				{Value: descr},
			]
		},
		FieldGroup#Price: {
			Data: [
				{Value: price, Label: '{i18n>Price}'},
				{Value: currency_code, Label: '{i18n>Currency}'},
			]
		},
	}
);

annotate Cars with @(
	UI: {
	  SelectionFields: [ ID, model, currency_code ],
        LineItem: [
            {Value: model, Label:'{i18n>Model}'},
            {Value: price, Label: '{i18n>Price}'},
			{Value: descr},
			{
				$Type : 'UI.DataField',
				Value : engineType.name,
			},
			{
				$Type : 'UI.DataField',
				Value : manufacturer.name,
			},
        ]
	},

){
	@Measures.ISOCurrency : currency.symbol
    price
};

entity Manufacturers : managed
{
    key ID : Integer;
    name : String(10)
        @title : '{i18n>Manufacturer}';
    descr : String(111);
    country : String(1000);
    cars : Association to many Cars on cars.manufacturer = $self;
}

entity EngineTypes : sap.common.CodeList
{
    key code : Integer;
    name : String
        @title : '{i18n>Engine}';
}

entity Orders : cuid, managed
{
    key OrderNo : UUID
        @readonly
        @title : '{i18n>OrderID}'
        @Core.Computed;
    Items : Composition of many OrderItems on Items.parent = $self;
    Customer: Association to one Customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customer',
       Parameters : [
           {
               $Type : 'Common.ValueListParameterInOut',
               ValueListProperty : 'firstName',
               LocalDataProperty: 'Customer/firstName'
           },
           {
               $Type : 'Common.ValueListParameterDisplayOnly',
               ValueListProperty : 'lastName'
           },
           {
               $Type : 'Common.ValueListParameterInOut',
               LocalDataProperty : Customer_ID,
               ValueListProperty : 'ID',
           },
       ],
    }  @Common.Label : '{i18n>Customer}';
    currency : Currency;
    price : Decimal(9,2);
}

entity Customer 
{
    key ID : UUID;
    firstName : String(100)  @title : '{i18n>Firstname}';
    lastName : String(100)  @title : '{i18n>Lastname}';
    street : String(100)  @title : '{i18n>Street}';
    housenumber : String(100)  @title : '{i18n>Housenumber}';
    postalCode : String(100)  @title : '{i18n>Postalcode}';
    city : String(100)  @title : '{i18n>City}';
    country : String(100)  @title : '{i18n>Country}';
    email: String(100)  @title: '{i18n>Email}' @Communication.IsEmailAddress;
    phone: String(100) @title: '{i18n>Phone}' @Communication.IsPhoneNumber;
    Orders: Association to many Orders on Orders.Customer = $self;
}



entity OrderItems
{
    key ID : UUID;
    parent : Association to one Orders;
    car : Association to one Cars;
    amount : Integer @title: '{i18n>Amount}';
    netAmount : Decimal(9,2);
}


type EngineType : Association to one EngineTypes;
