package customer.enterprice_product.Local_Handler;

import com.sap.cds.services.handler.EventHandler;

import cds.gen.employeeproject.EmployeeProject_;
import cds.gen.employeeproject.Employees;
import com.sap.cds.services.cds.CqnService;
import com.sap.cds.services.handler.annotations.Before;
import com.sap.cds.services.handler.annotations.ServiceName;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@ServiceName(EmployeeProject_.CDS_NAME)
public class EmployeesHandler implements EventHandler {

    private static final Logger log = LoggerFactory.getLogger(EmployeesHandler.class);

    @Before(event = CqnService.EVENT_CREATE, entity = "EmployeeProject.Employees")
    public void beforeCreate(Employees emp) {

        log.info("SAVE button pressed - CREATE triggered");

        if (emp.getEmpName() == null ||
                emp.getEmpName().isBlank()) {

            throw new RuntimeException("Employee name is mandatory");
        }
    }

    @Before(event = CqnService.EVENT_UPDATE, entity = "EmployeeProject.Employees")
    public void beforeUpdate(Employees emp) {

        log.info("SAVE button pressed - UPDATE triggered");
    }
}
