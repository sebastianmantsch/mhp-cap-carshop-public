using AdminService as service from '../../srv/admin-service';

annotate service.Cars with @(
    UI.LineItem : [
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
            Label : 'manufacturer_ID',
            Value : manufacturer_ID,
        },
        {
            $Type : 'UI.DataField',
            Value : price,
        },
    ]
);
annotate service.Cars with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Label : 'manufacturer_ID',
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
                Label : 'stock',
                Value : stock,
            },
            {
                $Type : 'UI.DataField',
                Label : 'engineType_code',
                Value : engineType_code,
            },
            {
                $Type : 'UI.DataField',
                Label : 'enginePowerKw',
                Value : enginePowerKw,
            },
            {
                $Type : 'UI.DataField',
                Value : color,
            },
            {
                $Type : 'UI.DataField',
                Label : 'image',
                Value : image,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
    ]
);
