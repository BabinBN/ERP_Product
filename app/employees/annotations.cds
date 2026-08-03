using EmployeeProject as service from '../../srv/employee-project-service';
annotate service.Employees with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'department',
                Value : department,
            },
            {
                $Type : 'UI.DataField',
                Label : 'empCode',
                Value : empCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'empName',
                Value : empName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'salary',
                Value : salary,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Project',
            ID : 'Project',
            Target : 'projects/@UI.LineItem#Project',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'department',
            Value : department,
        },
        {
            $Type : 'UI.DataField',
            Label : 'empCode',
            Value : empCode,
        },
        {
            $Type : 'UI.DataField',
            Label : 'empName',
            Value : empName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'salary',
            Value : salary,
        },
        {
            $Type : 'UI.DataField',
            Value : projects.customer,
            Label : 'customer',
        },
        {
            $Type : 'UI.DataField',
            Value : projects.budget,
            Label : 'budget',
        },
        {
            $Type : 'UI.DataField',
            Value : projects.projectCode,
            Label : 'projectCode',
        },
        {
            $Type : 'UI.DataField',
            Value : projects.projectName,
            Label : 'projectName',
        },
    ],
    UI.SelectionFields : [
        empCode,
        department,
        empName,
        salary,
    ],
    UI.SelectionPresentationVariant #tableView : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View',
    },
    UI.LineItem #tableView : [
    ],
    UI.SelectionPresentationVariant #tableView1 : {
        $Type : 'UI.SelectionPresentationVariantType',
        PresentationVariant : {
            $Type : 'UI.PresentationVariantType',
            Visualizations : [
                '@UI.LineItem#tableView',
            ],
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [
            ],
        },
        Text : 'Table View 1',
    },
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : empName,
        },
        TypeName : '',
        TypeNamePlural : '',
        ImageUrl : empCode,
        Initials : department,
    },
);

annotate service.Employees with {
    empCode @Common.Label : 'empCode'
};

annotate service.Employees with {
    department @(
        Common.Label : 'department',
        UI.IsImageURL : true,
    )
};

annotate service.Employees with {
    empName @Common.Label : 'empName'
};

annotate service.Employees with {
    salary @Common.Label : 'salary'
};

annotate service.Projects with @(
    UI.LineItem #Project : [
        {
            $Type : 'UI.DataField',
            Value : customer,
            Label : 'customer',
        },
        {
            $Type : 'UI.DataField',
            Value : projectCode,
            Label : 'projectCode',
        },
        {
            $Type : 'UI.DataField',
            Value : projectName,
            Label : 'projectName',
        },
        {
            $Type : 'UI.DataField',
            Value : employee.department,
        },
        {
            $Type : 'UI.DataField',
            Value : employee.salary,
        },
    ]
);

