using { SAPB1 as external } from './external/SapBusinessOne';

@path : '/service/Purchase_Analytics'
service PurchaseAnalyticsService {
    
    @readonly
    entity PurchaseOrdersAnalytics as projection on external.PurchaseOrders
    {
        key DocEntry,
        DocNum,
        DocType,
        CardCode,
        CardName,
        DocDate,
        DocDueDate,
        TaxDate,
        NumAtCard,
        DiscountPercent,
        DiscountSum,
        PaidToDate,
        Comments,
        SalesPersonCode,
        Address,
        Address2,
        ShipToCode,
        PayToCode,
        PaymentGroupCode,
        PaymentMethod,
        Currency,
        WarehouseCode,
        ProjectCode,
        DocumentLines,
        DocStatus,
        
        @DefaultAggregation: #Sum
        @Analytics.Measure: true
        @title: 'Order Amount'
        DocTotal
    };
}

/* ========================================================================
   MAPPING FOR THE TEMPLATE WIZARD VALIDATOR & METRICS
   ======================================================================== */
annotate PurchaseAnalyticsService.PurchaseOrdersAnalytics with @(
  Aggregation.ApplySupported: {
    Transformations: [ 'aggregate', 'groupby', 'filter', 'search' ],
    GroupableProperties: [
      CardCode,
      CardName,
      DocumentStatus
    ],
    AggregatableProperties: [{
      $Type : 'Aggregation.AggregatablePropertyType',
      Property: DocTotal
    }]
  },

  Analytics.AggregatedProperty #totalDocTotal: {
    $Type : 'Analytics.AggregatedPropertyType',
    AggregatableProperty : DocTotal,
    AggregationMethod : 'sum',
    Name : 'totalDocTotal',
    ![@Common.Label]: 'Total Order Amount'
  }
);

/* ========================================================================
   GRAPH (UI.CHART) AND PRESENTATION VARIANT SETUP
   ======================================================================== */
annotate PurchaseAnalyticsService.PurchaseOrdersAnalytics with @(
  UI.Chart: {
    $Type : 'UI.ChartDefinitionType',
    Title: 'Purchase Order Value Summary by Vendor',
    ChartType : #Column,
    Dimensions: [ CardName ],
    DimensionAttributes: [{ $Type : 'UI.ChartDimensionAttributeType', Dimension: CardName, Role: #Category }],
    DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalDocTotal] ],
    MeasureAttributes: [{ $Type: 'UI.ChartMeasureAttributeType', DynamicMeasure: ![@Analytics.AggregatedProperty#totalDocTotal], Role: #Axis1 }]
  },

  UI.PresentationVariant: {
    $Type : 'UI.PresentationVariantType',
    Visualizations : [ '@UI.Chart', '@UI.LineItem' ]
  }
);

/* ========================================================================
   DEFINE SELECTION SCREEN FILTERS AND STANDARD TABLE COLUMNS
   ======================================================================== */
annotate PurchaseAnalyticsService.PurchaseOrdersAnalytics with @(
    UI: {
        SelectionFields : [ CardCode, DocStatus ],
        LineItem: [
            { $Type : 'UI.DataField', Value : DocEntry },
            { $Type : 'UI.DataField', Value : DocNum },
            { $Type : 'UI.DataField', Value : CardCode },
            { $Type : 'UI.DataField', Value : CardName },
            { $Type : 'UI.DataField', Value : DocTotal },
            { $Type : 'UI.DataField', Value : DocStatus }
        ]
    }
);

annotate PurchaseAnalyticsService.PurchaseOrdersAnalytics with {
  CardName       @Analytics.Dimension: true;
 DocStatus       @Analytics.Dimension: true;
};