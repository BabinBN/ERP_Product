package customer.enterprice_product.External_Handler;
import java.util.List;
import java.util.Map;
import org.springframework.http.HttpHeaders;         
import org.springframework.http.MediaType; 
import org.springframework.http.HttpEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;
import org.springframework.stereotype.Component;

// import com.sap.cds.services.handler.EventHandler;
// import com.sap.cloud.sdk.cloudplatform.connectivity.DestinationAccessor;
import com.sap.cloud.sdk.cloudplatform.connectivity.HttpDestination;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Component
public class Login_session  {
    
    public String loginToB1(HttpDestination destination) {

        RestTemplate restTemplate = new RestTemplate();

        String loginUrl =
                destination.getUri().toString() + "/Login";

        String userJson = destination.get("User")
                .map(Object::toString)
                .getOrElseThrow(() ->
                        new RuntimeException("User missing in destination"));

        String companyDB;
        String userName;

        try {

            ObjectMapper mapper = new ObjectMapper();

            JsonNode node = mapper.readTree(userJson);

            companyDB = node.get("CompanyDB").asText();
            userName = node.get("UserName").asText();

        } catch (Exception e) {
            throw new RuntimeException("Invalid User JSON in destination", e);
        }

        String password = destination.get("Password")
                .map(Object::toString)
                .getOrElseThrow(() ->
                        new RuntimeException("Password missing in destination"));

        Map<String, String> loginBody = Map.of(
                "CompanyDB", companyDB,
                "UserName", userName,
                "Password", password
        );

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, String>> request =
                new HttpEntity<>(loginBody, headers);

        ResponseEntity<String> response =
                restTemplate.postForEntity(
                        loginUrl,
                        request,
                        String.class);

        List<String> cookies =
                response.getHeaders().get("Set-Cookie");

        if (cookies == null || cookies.isEmpty()) {
            throw new RuntimeException("B1 Login failed");
        }

        String b1Session = cookies.stream()
                .filter(c -> c.startsWith("B1SESSION"))
                .findFirst()
                .orElseThrow(() ->
                        new RuntimeException("B1SESSION not found"));

        String routeId = cookies.stream()
                .filter(c -> c.startsWith("ROUTEID"))
                .findFirst()
                .orElse("");

        return b1Session + "; " + routeId;
    }
}