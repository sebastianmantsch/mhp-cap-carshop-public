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
    key ID : Integer;
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
    color : String(30);
    image : LargeBinary
        @Core.MediaType : 'image/png';
}

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
   
    virtual total : Decimal(9,2)
        @readonly;
    currency : Currency;
    key customer : Association to one Customer;
}

entity OrderItems
{
    key ID : UUID;
    parent : Association to one Orders;
    car : Association to one Cars;
    amount : Integer;
    netAmount : Decimal(9,2);
}

entity Customer
{
    key ID : UUID
        @Core.Computed;
    orders : Association to many Orders on orders.customer = $self;
    firstName : String(100);
    lastName : String(100);
    street : String(100);
    housenumber : String(100);
    postalCode : String(100);
    city : String(100);
    country : String(100);
}

type EngineType : Association to one EngineTypes;
