sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchaseorder/test/integration/pages/PurchaseOrdersList",
	"purchaseorder/test/integration/pages/PurchaseOrdersObjectPage"
], function (JourneyRunner, PurchaseOrdersList, PurchaseOrdersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchaseorder') + '/test/flpSandbox.html#purchaseorder-tile',
        pages: {
			onThePurchaseOrdersList: PurchaseOrdersList,
			onThePurchaseOrdersObjectPage: PurchaseOrdersObjectPage
        },
        async: true
    });

    return runner;
});

