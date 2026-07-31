namespace ERP_Product;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Employees : cuid, managed {
    department : String(50);
    empCode    : String(20);
    empName    : String(20);
    salary     : Decimal(15, 2);
    projects   : Composition of many Projects
                     on projects.employee = $self;
}

entity Projects : cuid, managed {
    budget      : Decimal(15, 2);
    customer    : String(100);
    projectCode : String(20);
    projectName : String(100);
    employee    : Association to Employees;
}
