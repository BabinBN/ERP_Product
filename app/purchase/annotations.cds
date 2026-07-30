using Purchase_order as service from '../../srv/purchase-order-service';
annotate service.PurchaseOrders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Label : 'Comments',
                Value : Comments,
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
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Vendor & Addresses',
            ID : 'VendorAddresses',
            Target : '@UI.FieldGroup#VendorAddresses',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Payment Details',
            ID : 'PaymentDetails',
            Target : '@UI.FieldGroup#PaymentDetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Logistics',
            ID : 'Logistics',
            Target : '@UI.FieldGroup#Logistics',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : DocNum,
            Label : 'Purchase Order No.',
        },
        {
            $Type : 'UI.DataField',
            Value : CardCode,
        },
        {
            $Type : 'UI.DataField',
            Value : CardName,
        },
        {
            $Type : 'UI.DataField',
            Value : Address,
            Label : 'Address',
        },
        {
            $Type : 'UI.DataField',
            Value : DocDate,
        },
        {
            $Type : 'UI.DataField',
            Value : Currency,
            Label : 'Currency',
        },
        {
            $Type : 'UI.DataField',
            Value : DocTotal,
            Label : 'DocTotal',
        },
    ],
    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Purchase Order Overview',
            ID : 'PurchaseOrderOverview',
            Target : '@UI.FieldGroup#PurchaseOrderOverview',
        },
    ],
    UI.FieldGroup #PurchaseOrderOverview : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : DocNum,
                Label : 'Purchase Order No.',
            },
            {
                $Type : 'UI.DataField',
                Value : CardName,
                Label : 'Vendor Name',
            },
            {
                $Type : 'UI.DataField',
                Value : CardCode,
                Label : 'Vendor Code',
            },
            {
                $Type : 'UI.DataField',
                Value : DocStatus,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : DocDate,
                Label : 'Posting Date',
            },
            {
                $Type : 'UI.DataField',
                Value : DocDueDate,
                Label : 'Delivery Date',
            },
            {
                $Type : 'UI.DataField',
                Value : DocTotal,
                Label : 'Total Amount',
            },
            {
                $Type : 'UI.DataField',
                Value : Currency,
                Label : 'Currency',
            },
        ],
    },
    UI.FieldGroup #VendorAddresses : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : CardCode,
                Label : 'CardCode',
            },
            {
                $Type : 'UI.DataField',
                Value : CardName,
                Label : 'CardName',
            },
            {
                $Type : 'UI.DataField',
                Value : Address,
                Label : 'Address',
            },
            {
                $Type : 'UI.DataField',
                Value : Address2,
                Label : 'Address2',
            },
            {
                $Type : 'UI.DataField',
                Value : ShipToCode,
                Label : 'ShipToCode',
            },
            {
                $Type : 'UI.DataField',
                Value : PayToCode,
                Label : 'PayToCode',
            },
        ],
    },
    UI.FieldGroup #PaymentDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PaymentGroupCode,
                Label : 'PaymentGroupCode',
            },
            {
                $Type : 'UI.DataField',
                Value : PaymentMethod,
                Label : 'PaymentMethod',
            },
            {
                $Type : 'UI.DataField',
                Value : Currency,
                Label : 'Currency',
            },
            {
                $Type : 'UI.DataField',
                Value : DiscountPercent,
                Label : 'DiscountPercent',
            },
            {
                $Type : 'UI.DataField',
                Value : DiscountSum,
                Label : 'DiscountSum',
            },
            {
                $Type : 'UI.DataField',
                Value : PaidToDate,
                Label : 'PaidToDate',
            },
        ],
    },
    UI.FieldGroup #Logistics : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : WarehouseCode,
                Label : 'WarehouseCode',
            },
            {
                $Type : 'UI.DataField',
                Value : ProjectCode,
                Label : 'ProjectCode',
            },
            {
                $Type : 'UI.DataField',
                Value : SalesPersonCode,
                Label : 'SalesPersonCode',
            },
        ],
    },
    UI.SelectionFields : [
        CardCode,
        CardName,
        DocDate,
        DocType,
    ],
    UI.HeaderInfo : {
        ImageUrl : CardCode,
        TypeName : '',
        TypeNamePlural : '',
        TypeImageUrl : 'sap-icon://customer',
    },
    );

annotate service.PurchaseOrders with {
    CardCode @Common.Label : 'CardCode'
};

annotate service.PurchaseOrders with {
    CardName @Common.Label : 'CardName'
};

annotate service.PurchaseOrders with {
    DocDate @Common.Label : 'DocDate'
};

annotate service.PurchaseOrders with {
    DocType @Common.Label : 'DocType'
};

