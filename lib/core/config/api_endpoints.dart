class ApiEndpoints {
  // Authentication
  static const String sendOtp = '/employee/send-otp-forgot-password';
  static const String verifyOtp = '/employee/verify-otp-forgot-password';
  static const String resetPassword = '/employee/reset-password';

  // Organizational Structure
  static const String companyStructure = '/employee/company-structure';
  static const String companyStructureRole = '/employee/company-structure/role';
  static const String companyStructureRoleDelete = '/employee/company-structure/role/delete';
  static const String superiorEmployee = '/employee/company-structure/superior-employee';
  static const String superiorEmployeeUpdate =
      '/employee/company-structure/superior-employee/update';
  static const String superiorEmployeeDelete =
      '/employee/company-structure/superior-employee/delete';
  static const String superiorEmployeeDepartment =
      '/employee/company-structure/superior-employee/department';
  static const String superiorEmployeeDepartmentEmployee =
      '/employee/company-structure/superior-employee/department/employee';
  static const String superiorEmployeeDepartmentWorker =
      '/employee/company-structure/superior-employee/department/worker';
  static const String companyStructureDetail = '/employee/company-structure/get-by-id';
  static const String userRole = '/employee/user-role';
  static const String userRoleUpdate = '/employee/user-role/update';
  static const String userRoleDelete = '/employee/user-role/delete';
  static const String jobTitle = '/job-title';
  static const String getAllDepartment = '/department';
  static const String employmentLevel = '/employment-level';
  static const String filterDropdown = '/filter-dropdown';
  static const String getAllEmployees = '/employee';

  // Menu Access
  static const String employeeMenuApplication = '/employee/employee-menu-application';
  static const String menuApplication = '/employee/menu-application';
  static const String createEmployeeMenuApplication =
      '/employee/employee-menu-application/create';
  static const String deleteEmployeeMenuApplication =
      '/employee/employee-menu-application/delete-by-employee';

  // Screen Settings
  static const String screenSetting = '/record-screen-app';
}
