sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchaseorderanalytics/test/integration/pages/PurchaseOrdersAnalyticsList.gen",
	"purchaseorderanalytics/test/integration/pages/PurchaseOrdersAnalyticsObjectPage.gen"
], function (JourneyRunner, PurchaseOrdersAnalyticsListGenerated, PurchaseOrdersAnalyticsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchaseorderanalytics') + '/test/flpSandbox.html#purchaseorderanalytics-tile',
        pages: {
			onThePurchaseOrdersAnalyticsListGenerated: PurchaseOrdersAnalyticsListGenerated,
			onThePurchaseOrdersAnalyticsObjectPageGenerated: PurchaseOrdersAnalyticsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

