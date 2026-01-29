class ApiEndpoints {
  // Authentication
  static const String sendOtp = '/employee/send-otp-forgot-password';
  static const String verifyOtp = '/employee/verify-otp-forgot-password';
  static const String resetPassword = '/employee/reset-password';

  // Organizational Structure
  static const String companyStructure = '/company-structure';
  static const String companyStructureRole = '/company-structure/role';
  static const String companyStructureRoleDelete = '/company-structure/role/delete';
  static const String superiorEmployee = '/company-structure/superior-employee';
  static const String superiorEmployeeUpdate = '/company-structure/superior-employee/update';
  static const String superiorEmployeeDelete = '/company-structure/superior-employee/delete';
  static const String superiorEmployeeDepartment = '/company-structure/superior-employee/department';
  static const String superiorEmployeeDepartmentEmployee = '/company-structure/superior-employee/department/employee';
  static const String superiorEmployeeDepartmentWorker = '/company-structure/superior-employee/department/worker';
  static const String companyStructureDetail = '/company-structure/get-by-id';
  static const String userRole = '/user-role';
  static const String jobTitle = '/job-title';
  static const String getAllDepartment = '/department';
  static const String filterDropdown = '/filter-dropdown';
}
