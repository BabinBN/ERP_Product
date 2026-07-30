using Purchase_order as service from '../../srv/purchase-order-service';
annotate service.PurchaseOrders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'DocEntry',
                Value : DocEntry,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocNum',
                Value : DocNum,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocType',
                Value : DocType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocDate',
                Value : DocDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocDueDate',
                Value : DocDueDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'TaxDate',
                Value : TaxDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CardCode',
                Value : CardCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'CardName',
                Value : CardName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocStatus',
                Value : DocStatus,
            },
            {
                $Type : 'UI.DataField',
                Label : 'NumAtCard',
                Value : NumAtCard,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocTotal',
                Value : DocTotal,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DocTotalFc',
                Value : DocTotalFc,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscountPercent',
                Value : DiscountPercent,
            },
            {
                $Type : 'UI.DataField',
                Label : 'DiscountSum',
                Value : DiscountSum,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PaidToDate',
                Value : PaidToDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Comments',
                Value : Comments,
            },
            {
                $Type : 'UI.DataField',
                Label : 'SalesPersonCode',
                Value : SalesPersonCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address',
                Value : Address,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Address2',
                Value : Address2,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ShipToCode',
                Value : ShipToCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PayToCode',
                Value : PayToCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PaymentGroupCode',
                Value : PaymentGroupCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'PaymentMethod',
                Value : PaymentMethod,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Currency',
                Value : Currency,
            },
            {
                $Type : 'UI.DataField',
                Label : 'WarehouseCode',
                Value : WarehouseCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'ProjectCode',
                Value : ProjectCode,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'DocEntry',
            Value : DocEntry,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DocNum',
            Value : DocNum,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DocType',
            Value : DocType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DocDate',
            Value : DocDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'DocDueDate',
            Value : DocDueDate,
        },
    ],
);

