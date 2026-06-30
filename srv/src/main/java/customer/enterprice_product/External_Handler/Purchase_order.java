package customer.enterprice_product.External_Handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import com.sap.cloud.sdk.cloudplatform.connectivity.DestinationAccessor;
import com.sap.cloud.sdk.cloudplatform.connectivity.HttpDestination;

import com.sap.cds.Result;
import com.sap.cds.ResultBuilder;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.cds.CdsReadEventContext;
import com.sap.cds.services.handler.EventHandler;
import com.sap.cds.services.handler.annotations.On;
import com.sap.cds.services.handler.annotations.ServiceName;

import org.springframework.beans.factory.annotation.Autowired;

@Component
@ServiceName("Purchase_order")
public class Purchase_order implements EventHandler {
       @Autowired
    public Login_session loginsession;

    @On(event = CqnService.EVENT_READ, entity = "Purchase_order.PurchaseOrders")
    @SuppressWarnings("unchecked")
    public void onReadPurchaseOrders(CdsReadEventContext context) {

        HttpDestination destination = DestinationAccessor.getDestination("SAPB1").asHttp();
        String b1Url = destination.getUri().toString();

        // Step 1: Login using credentials from destination properties
        System.err.println("Logging in to B1 with destination: " + b1Url);
        String sessionCookie = loginsession.loginToB1(destination);

        // Step 2: Query B1 with the session cookie
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Cookie", sessionCookie);
        headers.set("Accept", "application/json");

        //   String query = b1Url + "/BusinessPartners?$select=CardCode,CardName,Currency&$top=1000&$orderby=CardCode";

        List<Map<String, Object>> allRecords = new ArrayList<>();
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // String nextUrl = b1Url + "/BusinessPartners?$select=CardCode,CardName,Currency,CurrentAccountBalance&$top=20&$orderby=CardCode";
        String nextUrl = b1Url + "/PurchaseOrders?$top=20";

        while (nextUrl != null) {

            ResponseEntity<Map> response = restTemplate.exchange(
                    nextUrl,
                    HttpMethod.GET,
                    entity,
                    Map.class);

            Map<String, Object> body = response.getBody();

            if (body == null) {
                break;
            }

            List<Map<String, Object>> records = (List<Map<String, Object>>) body.get("value");

            if (records != null) {
                allRecords.addAll(records);
            }

            String nextLink = null;

            if (body.containsKey("@odata.nextLink")) {
                nextLink = (String) body.get("@odata.nextLink");
            } else if (body.containsKey("odata.nextLink")) {
                nextLink = (String) body.get("odata.nextLink");
            }

            if (nextLink != null && !nextLink.isEmpty()) {
                if (nextLink.startsWith("http")) {
                    nextUrl = nextLink;
                } else {
                    nextUrl = b1Url + "/" + nextLink;
                }
            } else {
                nextUrl = null;
            }
        }

        System.out.println("Total Records : " + allRecords.size());

        // Step 3: Wrap rows along with the required inline count into a CAP Result object
        Result result = ResultBuilder.selectedRows(allRecords)
                                     .inlineCount(allRecords.size())
                                     .result();

        context.setResult(result);
    }
}
