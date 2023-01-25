namespace mhp.capire.carshop;

using {
    Currency,
    managed,
    sap,
    cuid
} from '@sap/cds/common';

entity Cars : cuid, managed {
    descr         : localized String(1111)
                                                     @title            : '{i18n>Description}';
    model         : String(100)
                                                     @title            : '{i18n>Model}';
    manufacturer  : Association to one Manufacturers @title: '{i18n>Manufacturer}' @Common.ValueList : {
                        $Type          : 'Common.ValueListType',
                        CollectionPath : 'Manufacturers',
                        Parameters     : [{
                            $Type             : 'Common.ValueListParameterInOut',
                            LocalDataProperty : manufacturer_ID,
                            ValueListProperty : 'ID',
                        }, ]
                    } ;
    price         : Decimal                          @title            : '{i18n>Price}'          @Measures.Unit                                                                                      : currency_code  @Measures.ISOCurrency : 'currency_code';
    currency      : Currency                         @title            : '{i18n>Currency}';
    stock         : Integer                          @title            : '{i18n>Stock}';
    engineType    : Association to one EngineTypes                                               @title : '{i18n>engineType}'  @Common.ValueList : {
                                                                                                     $Type          : 'Common.ValueListType',
                                                                                                     CollectionPath : 'EngineTypes',
                                                                                                     Parameters     : [{
                                                                                                         $Type             : 'Common.ValueListParameterInOut',
                                                                                                         LocalDataProperty : engineType_code,
                                                                                                         ValueListProperty : 'code',
                                                                                                     }, ],
                                                                                                 }  @Common.ValueListWithFixedValues : true  @Common.Text : engineType.name  @Common.TextArrangement : #TextOnly;
    enginePowerKw : Integer                          @title            : '{i18n>enginePowerKw}'  @Measures.Unit                                                                                      : '{i18n>KW}'    @Measures.ISOCurrency : 'KW';
    enginePowerPS : Integer                          @title            : '{i18n>enginePowerPS}'  @Core.Computed                                                                                                       @Measures.Unit        : '{i18n>HP}'  @Measures.ISOCurrency : '{i18n>HP}';
    color         : String(30)                       @title            : '{i18n>Color}';
    image         : LargeBinary                      @title            : '{i18n>image}'          @Core.MediaType                                                                                     : 'image/png';
}

@Common.SemanticObject  : 'Car'
annotate Cars with @(
    Common : {Label : '{i18n>Title}'},
    UI     : {
        HeaderInfo          : {
            TypeName       : '{i18n>Car}',
            TypeNamePlural : '{i18n>Cars}',
            Description    : {Value : model},
            Image          : image

        },
        HeaderFacets        : [{
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Description}',
            Target : '@UI.FieldGroup#Descr'
        }, ],
        Facets              : [{
            $Type  : 'UI.ReferenceFacet',
            Label  : '{i18n>Details}',
            Target : '@UI.FieldGroup#General'
        }, ],
        FieldGroup #Descr   : {Data : [{Value : descr}, ]},
        FieldGroup #General : {
            $Type : 'UI.FieldGroupType',
            Data  : [
                {
                    $Type : 'UI.DataField',
                    Value : ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : descr,
                },
                {
                    $Type : 'UI.DataField',
                    Value : model,
                },
                {
                    $Type : 'UI.DataField',
                    Value : manufacturer_ID,
                },
                {
                    $Type : 'UI.DataField',
                    Value : price,
                },
                {
                    $Type : 'UI.DataField',
                    Value : currency_code,
                },
                {
                    $Type : 'UI.DataField',
                    Value : stock,
                },
                {
                    $Type : 'UI.DataField',
                    Value : engineType_code,
                },
                {
                    $Type : 'UI.DataField',
                    Value : enginePowerKw
                },
                {
                    $Type : 'UI.DataField',
                    Value : enginePowerPS
                },
                {
                    $Type : 'UI.DataField',
                    Value : color,
                },
                {
                    $Type : 'UI.DataField',
                    Value : image,
                },
            ],
        },


        SelectionFields     : [
            ID,
            model,
            manufacturer_ID
        ],
        LineItem            : [
            {Value : image},
            {
                Value : model,
                Label : '{i18n>Model}'
            },
            {
                Value : price,
                Label : '{i18n>Price}'
            },
            {Value : descr},
            {
                $Type : 'UI.DataField',
                Value : engineType.name,
            },
            {
                $Type : 'UI.DataField',
                Value : manufacturer_ID,
            },
            {
            $Type : 'UI.DataFieldForIntentBasedNavigation',
            SemanticObject : 'Car',
            Action : 'order',
            Label : 'Create Order',
            Inline: true,
            Determining: true,
            ![@UI.Importance] : #High,
        }
        ]

    }
);

 
entity Manufacturers : cuid, managed {
    key ID      : UUID @Common.Text : 'name' @Common.TextArrangement : #TextOnly;
        name    : String(10)
        @title : '{i18n>Manufacturer}';
        descr   : String(111);
        country : String(3);
        cars    : Association to many Cars
                      on cars.manufacturer = $self;
}

entity EngineTypes : sap.common.CodeList {
    key code : Integer  @Common.Text : name  @Common.TextArrangement : #TextOnly;
        name : String
                        @title       : '{i18n>Engine}';
}

entity Orders : cuid, managed {
                                            @readonly
                                            @title            : '{i18n>OrderID}'
    Items    : Composition of many OrderItems
                   on Items.parent = $self;
    Customer : Association to one Customer  @Common.ValueList : {
                                                $Type          : 'Common.ValueListType',
                                                CollectionPath : 'Customer',
                                                Parameters     : [
                                                    {
                                                        $Type             : 'Common.ValueListParameterInOut',
                                                        ValueListProperty : 'firstName',
                                                        LocalDataProperty : 'Customer/firstName'
                                                    },
                                                    {
                                                        $Type             : 'Common.ValueListParameterDisplayOnly',
                                                        ValueListProperty : 'lastName'
                                                    },
                                                    {
                                                        $Type             : 'Common.ValueListParameterInOut',
                                                        LocalDataProperty : Customer_ID,
                                                        ValueListProperty : 'ID',
                                                    },
                                                ],
                                            }  @Common.Label : '{i18n>Customer}';
    currency : Currency;
    price    : Decimal(9, 2);
}

entity Customer : cuid {
    firstName   : String(100)  @title : '{i18n>Firstname}';
    lastName    : String(100)  @title : '{i18n>Lastname}';
    street      : String(100)  @title : '{i18n>Street}';
    housenumber : String(100)  @title : '{i18n>Housenumber}';
    postalCode  : String(100)  @title : '{i18n>Postalcode}';
    city        : String(100)  @title : '{i18n>City}';
    country     : String(100)  @title : '{i18n>Country}';
    email       : String(100)  @title : '{i18n>Email}'  @Communication.IsEmailAddress;
    phone       : String(100)  @title : '{i18n>Phone}'  @Communication.IsPhoneNumber;
    Orders      : Association to many Orders
                      on Orders.Customer = $self;
}


entity OrderItems : cuid {
    parent    : Association to one Orders;
    car       : Association to one Cars;
    amount    : Integer @title : '{i18n>Amount}';
    netAmount : Decimal(9, 2);
}
