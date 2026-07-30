sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchase/test/integration/pages/PurchaseOrdersList.gen",
	"purchase/test/integration/pages/PurchaseOrdersObjectPage.gen"
], function (JourneyRunner, PurchaseOrdersListGenerated, PurchaseOrdersObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchase') + '/test/flpSandbox.html#purchase-tile',
        pages: {
			onThePurchaseOrdersListGenerated: PurchaseOrdersListGenerated,
			onThePurchaseOrdersObjectPageGenerated: PurchaseOrdersObjectPageGenerated
        },
        async: true
    });

    return runner;
});

