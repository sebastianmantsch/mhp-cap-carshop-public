using CatalogService as service from '../../srv/catalog-service';

annotate service.Orders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : OrderNo,
        },
        {
            $Type : 'UI.DataField',
            Label : 'total',
            Value : total,
        },
        {
            $Type : 'UI.DataField',
            Value : currency_code,
        },
    ]
);
annotate service.Orders with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : OrderNo,
            },
            {
                $Type : 'UI.DataField',
                Label : 'total',
                Value : total,
            },
            {
                $Type : 'UI.DataField',
                Value : currency_code,
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
