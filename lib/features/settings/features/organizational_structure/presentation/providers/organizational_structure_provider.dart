// import 'package:flutter/foundation.dart';
// import '../../domain/entities/department_entity.dart';
// import '../../domain/entities/employee_entity.dart';
// import '../../domain/entities/employment_level_entity.dart';
// import '../../domain/entities/job_title_entity.dart';
// import '../../domain/entities/organizational_structure_entity.dart';
// import '../../domain/entities/user_role_entity.dart';
// import '../../domain/usecases/get_company_structure.dart';
// import '../../domain/usecases/get_organizational_data.dart';
// import '../../domain/usecases/manage_structure_role.dart';
// import '../../domain/usecases/manage_superior_employee.dart';
// import '../../domain/usecases/manage_job_title.dart';
// import '../../domain/usecases/manage_department.dart';
// import '../../domain/usecases/manage_employment_level.dart';
// import '../../domain/usecases/manage_user_role.dart';

// class OrganizationalStructureProvider with ChangeNotifier {
//   final GetCompanyStructure getCompanyStructure;
//   final ManageStructureRole manageStructureRole;
//   final ManageSuperiorEmployee manageSuperiorEmployee;
//   final GetOrganizationalData getOrganizationalData;
//   final ManageJobTitle manageJobTitle;
//   final ManageDepartment manageDepartment;
//   final ManageEmploymentLevel manageEmploymentLevel;
//   final ManageUserRole manageUserRole;

//   OrganizationalStructureProvider({
//     required this.getCompanyStructure,
//     required this.manageStructureRole,
//     required this.manageSuperiorEmployee,
//     required this.getOrganizationalData,
//     required this.manageJobTitle,
//     required this.manageDepartment,
//     required this.manageEmploymentLevel,
//     required this.manageUserRole,
//   });

//   bool _isLoading = false;
//   bool get isLoading => _isLoading;

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   List<OrganizationalStructureEntity> _structures = [];
//   List<OrganizationalStructureEntity> get structures => _structures;

//   List<EmploymentLevelEntity> _userRoles = [];
//   List<EmploymentLevelEntity> get userRoles => _userRoles;

//   List<JobTitleEntity> _jobTitles = [];
//   List<JobTitleEntity> get jobTitles => _jobTitles;

//   List<DepartmentEntity> _departments = [];
//   List<DepartmentEntity> get departments => _departments;

//   List<EmploymentLevelEntity> _employmentLevels = [];
//   List<EmploymentLevelEntity> get employmentLevels => _employmentLevels;

//   List<UserRoleEntity> _userRoleHierarchy = [];
//   List<UserRoleEntity> get userRoleHierarchy => _userRoleHierarchy;

//   List<EmployeeEntity> _employees = [];
//   List<EmployeeEntity> get employees => _employees;

//   OrganizationalStructureEntity? get currentStructure =>
//       _structures.isNotEmpty ? _structures.first : null;

//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }

//   void _setError(String? message) {
//     _errorMessage = message;
//     notifyListeners();
//   }

//   Future<void> loadCompanyStructure(String typeStructure) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getCompanyStructure(typeStructure);

//     result.fold((failure) => _setError(failure.message), (structures) {
//       _structures = structures;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   Future<bool> createStructureRole({
//     required int companyStructureId,
//     required List<int> userRoleIds,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageStructureRole.createRole(
//       companyStructureId: companyStructureId,
//       userRoleIds: userRoleIds,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteStructureRole(int id) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageStructureRole.deleteRole(id);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> addSuperiorEmployee({
//     required int companyStructureId,
//     required int roleStructureId,
//     required int employeeId,
//     required int jobTitleId,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.addSuperiorEmployee(
//       companyStructureId: companyStructureId,
//       roleStructureId: roleStructureId,
//       employeeId: employeeId,
//       jobTitleId: jobTitleId,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> editSuperiorEmployee({
//     required int superiorEmployeeId,
//     required int employeeId,
//     required int jobTitleId,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.editSuperiorEmployee(
//       superiorEmployeeId: superiorEmployeeId,
//       employeeId: employeeId,
//       jobTitleId: jobTitleId,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteSuperiorEmployee(int superiorEmployeeId) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.deleteSuperiorEmployee(superiorEmployeeId);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> addDepartment({
//     required int superiorEmployeeStructureId,
//     required int departmentId,
//     required List<int> employeeIds,
//     required List<int> workerIds,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.addDepartment(
//       superiorEmployeeStructureId: superiorEmployeeStructureId,
//       departmentId: departmentId,
//       employeeIds: employeeIds,
//       workerIds: workerIds,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> editEmployeeDepartment({
//     required int id,
//     required List<int> employeeIds,
//     required List<int> deleteEmployeeIds,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.editEmployeeDepartment(
//       id: id,
//       employeeIds: employeeIds,
//       deleteEmployeeIds: deleteEmployeeIds,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> editWorkerDepartment({
//     required int id,
//     required List<int> workerIds,
//     required List<int> deleteWorkerIds,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageSuperiorEmployee.editWorkerDepartment(
//       id: id,
//       workerIds: workerIds,
//       deleteWorkerIds: deleteWorkerIds,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<void> loadUserRoles(String typeBranch) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getUserRoles(typeBranch);

//     result.fold((failure) => _setError(failure.message), (roles) {
//       _userRoles = roles;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   Future<void> loadJobTitles({required String typeRole, required String typeBranch}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getJobTitles(
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     result.fold((failure) => _setError(failure.message), (titles) {
//       _jobTitles = titles;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   Future<void> loadDepartments() async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getDepartments();

//     result.fold((failure) => _setError(failure.message), (depts) {
//       _departments = depts;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   Future<bool> addJobTitle({
//     required String name,
//     required String typeRole,
//     required String typeBranch,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageJobTitle.addJobTitle(
//       name: name,
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> updateJobTitle({required int id, required String name}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageJobTitle.updateJobTitle(id: id, name: name);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteJobTitle(int id) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageJobTitle.deleteJobTitle(id);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   void clearError() {
//     _errorMessage = null;
//     notifyListeners();
//   }

//   Future<void> loadDepartmentsByType({required String typeRole, required String typeBranch}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getDepartmentsByType(
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     result.fold((failure) => _setError(failure.message), (depts) {
//       _departments = depts;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   Future<bool> addDepartmentData({
//     required String name,
//     required String typeRole,
//     required String typeBranch,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageDepartment.addDepartment(
//       name: name,
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> updateDepartmentData({required int id, required String name}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageDepartment.updateDepartment(id: id, name: name);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteDepartmentData(int id) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageDepartment.deleteDepartment(id);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   // Employment Level methods
//   Future<void> loadEmploymentLevelsByType({required String typeRole}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getEmploymentLevelsByType(typeRole: typeRole);

//     result.fold(
//       (failure) {
//         _setError(failure.message);
//         _employmentLevels = [];
//       },
//       (employmentLevels) {
//         _employmentLevels = employmentLevels;
//       },
//     );

//     _setLoading(false);
//   }

//   Future<bool> addEmploymentLevelData({required String name, required String typeRole}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageEmploymentLevel.addEmploymentLevel(name: name, typeRole: typeRole);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> updateEmploymentLevelData({required int id, required String name}) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageEmploymentLevel.updateEmploymentLevel(id: id, name: name);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteEmploymentLevelData(int id) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageEmploymentLevel.deleteEmploymentLevel(id);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   // User Role Hierarchy methods
//   Future<void> loadUserRoleHierarchy(String typeRole) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getUserRolesByType(typeRole);

//     result.fold(
//       (failure) {
//         _setError(failure.message);
//         _userRoleHierarchy = [];
//       },
//       (roles) {
//         _userRoleHierarchy = roles;
//       },
//     );

//     _setLoading(false);
//   }

//   Future<void> loadEmployees() async {
//     _setLoading(true);
//     _setError(null);

//     final result = await getOrganizationalData.getEmployees();

//     result.fold((failure) => _setError(failure.message), (employees) {
//       _employees = employees;
//       notifyListeners();
//     });

//     _setLoading(false);
//   }

//   // User Role Management methods
//   Future<bool> addUserRoleData({
//     required String name,
//     int? supervisorRoleId,
//     required String typeRole,
//     required String typeBranch,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageUserRole.addUserRole(
//       name: name,
//       supervisorRoleId: supervisorRoleId,
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> updateUserRoleData({
//     required int id,
//     required String name,
//     int? supervisorRoleId,
//     required String typeRole,
//     required String typeBranch,
//   }) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageUserRole.updateUserRole(
//       id: id,
//       name: name,
//       supervisorRoleId: supervisorRoleId,
//       typeRole: typeRole,
//       typeBranch: typeBranch,
//     );

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }

//   Future<bool> deleteUserRoleData(int id) async {
//     _setLoading(true);
//     _setError(null);

//     final result = await manageUserRole.deleteUserRole(id);

//     _setLoading(false);

//     return result.fold((failure) {
//       _setError(failure.message);
//       return false;
//     }, (_) => true);
//   }
// }
