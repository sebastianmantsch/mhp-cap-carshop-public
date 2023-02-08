
namespace mhp.capire.carshop;
/**
 * Annotations for schema that are relevant for all services
 * using this data model.
 */


@Common.SemanticObject  : 'Car'
annotate Cars @(
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
                  {
                    $Type : 'UI.DataField',
                    Value : createdAt,
                },
                  {
                    $Type : 'UI.DataField',
                    Value : updatedAt
                }
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
                $Type : 'UI.DataField',
                Value : createdAt,
            },
             {
                $Type : 'UI.DataField',
                Value : updatedAt,
            },
            {
            $Type : 'UI.DataFieldForIntentBasedNavigation',
            SemanticObject : 'Car',
            Action : 'order',
            Label : 'Create Order',
            Inline: true,
            Determining: true,
            ![@UI.Importance] : #High
        }
        ]

    }
) {
    manufacturer @Common.ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'Manufacturers',
        Parameters     : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : manufacturer_ID,
            ValueListProperty : 'ID',
        }, ]
    };
    engineType   @Common.ValueList : {
        $Type          : 'Common.ValueListType',
        CollectionPath : 'EngineTypes',
        Parameters     : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : engineType_code,
            ValueListProperty : 'code',
        }, ],
    }  @Common.ValueListWithFixedValues : true  @Common.Text : engineType.name  @Common.TextArrangement : #TextOnly;


};


annotate Orders {
    Customer @Common.ValueList : {
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
                                            } 

}
