sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchaseorder/test/integration/pages/PurchaseOrdersList.gen",
	"purchaseorder/test/integration/pages/PurchaseOrdersObjectPage.gen"
], function (JourneyRunner, PurchaseOrdersListGenerated, PurchaseOrdersObjectPageGenerated) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchaseorder') + '/test/flpSandbox.html#purchaseorder-tile',
        pages: {
			onThePurchaseOrdersListGenerated: PurchaseOrdersListGenerated,
			onThePurchaseOrdersObjectPageGenerated: PurchaseOrdersObjectPageGenerated
        },
        async: true
    });

    return runner;
});

