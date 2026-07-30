package customer.enterprice_product.External_Handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
@ServiceName("PurchaseAnalyticsService")
public class purchaseorder_analytics implements EventHandler {

    @Autowired
    public Login_session loginsession;

    @On(event = CqnService.EVENT_READ, entity = "PurchaseAnalyticsService.PurchaseOrdersAnalytics")
    @SuppressWarnings("unchecked")
    public void onReadPurchaseOrders(CdsReadEventContext context) {

        HttpDestination destination = DestinationAccessor.getDestination("SAPB1").asHttp();
        String b1Url = destination.getUri().toString();

        System.err.println("!!! ANALYTICS HANDLER RUNNING FOR EXT-API ROLLING UP !!!");
        String sessionCookie = loginsession.loginToB1(destination);

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Cookie", sessionCookie);
        headers.set("Accept", "application/json");

        List<Map<String, Object>> baseRecords = new ArrayList<>();
        HttpEntity<String> entity = new HttpEntity<>(headers);

        // CORRECTION: Request DocumentStatus instead of DocStatus from the external
        // service layer API
        String nextUrl = b1Url
                + "/PurchaseOrders?$select=DocEntry,DocNum,DocType,CardCode,CardName,DocDate,DocTotal,DocumentStatus&$top=100";

        // Fetch raw rows from external service
        while (nextUrl != null) {
            ResponseEntity<Map> response = restTemplate.exchange(nextUrl, HttpMethod.GET, entity, Map.class);
            Map<String, Object> body = response.getBody();
            if (body == null)
                break;

            List<Map<String, Object>> records = (List<Map<String, Object>>) body.get("value");
            if (records != null) {
                for (Map<String, Object> record : records) {
                    Map<String, Object> cleanRecord = new HashMap<>(record);
                    if (cleanRecord.get("DocTotal") != null) {
                        Object docTotal = cleanRecord.get("DocTotal");
                        if (docTotal instanceof Number) {
                            cleanRecord.put("DocTotal", ((Number) docTotal).doubleValue());
                        }
                    }
                    baseRecords.add(cleanRecord);
                }
            }

            String nextLink = (body.containsKey("@odata.nextLink")) ? (String) body.get("@odata.nextLink") : null;
            nextUrl = (nextLink != null && !nextLink.isEmpty())
                    ? (nextLink.startsWith("http") ? nextLink : b1Url + "/" + nextLink)
                    : null;
        }

        // TARGET STRUCTURAL PAYLOAD HOLDER
        List<Map<String, Object>> responseRows = new ArrayList<>();

        // CHECK IF FIORI SENDS CHART GROUP-BY INSTRUCTIONS
        String cqnHqlString = context.getCqn().toString();
        if (cqnHqlString.contains("groupby") || cqnHqlString.contains("totalDocTotal")) {
            System.err.println(">>> APPLYING SYSTEM AGGREGATION ROLLUPS FOR CHART RENDERING <<<");

            // Mathematically group DocTotal values by unique CardName elements
            Map<String, Double> aggregatedMap = baseRecords.stream()
                    .filter(r -> r.get("CardName") != null)
                    .collect(Collectors.groupingBy(
                            r -> (String) r.get("CardName"),
                            Collectors.summingDouble(r -> (Double) r.getOrDefault("DocTotal", 0.0))));

            // Construct rows matching the exact totalDocTotal structural format requested
            // by Fiori
            for (Map.Entry<String, Double> entry : aggregatedMap.entrySet()) {
                Map<String, Object> aggregatedRow = new HashMap<>();
                aggregatedRow.put("CardName", entry.getKey());
                aggregatedRow.put("totalDocTotal", entry.getValue());
                responseRows.add(aggregatedRow);
            }
        } else {
            // No aggregation requested (Normal Table Data View)
            System.err.println(">>> RETURNING STANDARD LINE-ITEM DATA GRID ROWS <<<");
            responseRows = baseRecords;
        }

        System.out.println("Total Payload Output Size: " + responseRows.size());

        Result result = ResultBuilder.selectedRows(responseRows)
                .inlineCount(responseRows.size())
                .result();

        context.setResult(result);
    }
}

