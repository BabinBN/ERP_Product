using { SAPB1 as external } from './external/SapBusinessOne';

@path : '/service/Purchase_order'
service Purchase_order
{
    @cds.redirection.target
    @odata.draft.enabled
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

// annotate Purchase_order with @requires :
// [
//     'authenticated-user'
// ];