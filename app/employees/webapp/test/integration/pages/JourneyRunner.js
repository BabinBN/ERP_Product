sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"employees/test/integration/pages/EmployeesList.gen",
	"employees/test/integration/pages/EmployeesObjectPage.gen",
	"employees/test/integration/pages/ProjectsObjectPage.gen"
], function (JourneyRunner, EmployeesListGenerated, EmployeesObjectPageGenerated, ProjectsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('employees') + '/test/flpSandbox.html#employees-tile',
        pages: {
			onTheEmployeesListGenerated: EmployeesListGenerated,
			onTheEmployeesObjectPageGenerated: EmployeesObjectPageGenerated,
			onTheProjectsObjectPageGenerated: ProjectsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

