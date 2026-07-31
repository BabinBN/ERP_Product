using {
    ERP_Product.Employees as EmployeesEntity,
    ERP_Product.Projects  as ProjectsEntity
} from '../db/schema';

@path: '/service/local'
service EmployeeProject {
    
    @odata.draft.enabled
    entity Employees as projection on EmployeesEntity;
    entity Projects  as projection on ProjectsEntity;
}

annotate EmployeeProject with @requires: ['any'];
