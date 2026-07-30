using { SAPB1 as external } from './external/SapBusinessOne';

@path : '/service/Purchase_order'
service Purchase_order
{
    @cds.redirection.target
    // @readonly
    entity PurchaseOrders as
        projection on external.PurchaseOrders
        {
            *
        }
        excluding
        {
            DocTotalSys,
            VatSum,
            VatSumFc,
            Series,
            JournalMemo,
            FederalTaxID,
            UpdateDate,
            CreateDate,
            DataVersion
        };
}

// 1. Explicitly enable creation capabilities
annotate Purchase_order.PurchaseOrders with @Capabilities.InsertRestrictions : { Insertable : true };
annotate Purchase_order.PurchaseOrders with @Capabilities.UpdateRestrictions : { Updatable : true };

// 2. Mark the system-generated B1 primary key as Computed so Fiori doesn't ask for it
annotate Purchase_order.PurchaseOrders:DocEntry with @Core.Computed;

annotate Purchase_order with @requires :
[
    'any'
];
