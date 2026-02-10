import 'package:flutter/foundation.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/employment_level_entity.dart';
import '../../domain/entities/organizational_structure_entity.dart';
import '../../domain/usecases/get_company_structure.dart';
import '../../domain/usecases/get_organizational_data.dart';
import '../../domain/usecases/manage_structure_role.dart';
import '../../domain/usecases/manage_superior_employee.dart';

/// Provider for managing organizational structure operations
/// Handles company structure, roles, superior employees, and departments
class StructureProvider with ChangeNotifier {
  final GetCompanyStructure getCompanyStructure;
  final ManageStructureRole manageStructureRole;
  final ManageSuperiorEmployee manageSuperiorEmployee;
  final GetOrganizationalData getOrganizationalData;

  StructureProvider({
    required this.getCompanyStructure,
    required this.manageStructureRole,
    required this.manageSuperiorEmployee,
    required this.getOrganizationalData,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<OrganizationalStructureEntity> _structures = [];
  List<OrganizationalStructureEntity> get structures => _structures;

  List<EmploymentLevelEntity> _userRoles = [];
  List<EmploymentLevelEntity> get userRoles => _userRoles;

  List<DepartmentEntity> _departments = [];
  List<DepartmentEntity> get departments => _departments;

  List<EmployeeEntity> _employees = [];
  List<EmployeeEntity> get employees => _employees;

  OrganizationalStructureEntity? get currentStructure =>
      _structures.isNotEmpty ? _structures.first : null;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Load company structure by type
  Future<void> loadCompanyStructure(String typeStructure) async {
    _setLoading(true);
    _setError(null);

    final result = await getCompanyStructure(typeStructure);

    result.fold(
      (failure) => _setError(failure.message),
      (structures) {
        _structures = structures;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Create a new structure role
  Future<bool> createStructureRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageStructureRole.createRole(
      companyStructureId: companyStructureId,
      userRoleIds: userRoleIds,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Delete a structure role
  Future<bool> deleteStructureRole(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageStructureRole.deleteRole(id);

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Add a superior employee
  Future<bool> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.addSuperiorEmployee(
      companyStructureId: companyStructureId,
      roleStructureId: roleStructureId,
      employeeId: employeeId,
      jobTitleId: jobTitleId,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Edit a superior employee
  Future<bool> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.editSuperiorEmployee(
      superiorEmployeeId: superiorEmployeeId,
      employeeId: employeeId,
      jobTitleId: jobTitleId,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Delete a superior employee
  Future<bool> deleteSuperiorEmployee(int superiorEmployeeId) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.deleteSuperiorEmployee(
      superiorEmployeeId,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Add a department to structure
  Future<bool> addDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.addDepartment(
      superiorEmployeeStructureId: superiorEmployeeStructureId,
      departmentId: departmentId,
      employeeIds: employeeIds,
      workerIds: workerIds,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Edit employee department
  Future<bool> editEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.editEmployeeDepartment(
      id: id,
      employeeIds: employeeIds,
      deleteEmployeeIds: deleteEmployeeIds,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Edit worker department
  Future<bool> editWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.editWorkerDepartment(
      id: id,
      workerIds: workerIds,
      deleteWorkerIds: deleteWorkerIds,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Update department
  Future<bool> updateDepartment({
    required int id,
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.updateDepartment(
      id: id,
      superiorEmployeeStructureId: superiorEmployeeStructureId,
      departmentId: departmentId,
      employeeIds: employeeIds,
    );

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Delete department
  Future<bool> deleteDepartment(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageSuperiorEmployee.deleteDepartment(id);

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Load user roles by branch type
  Future<void> loadUserRoles(String typeBranch) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getUserRoles(typeBranch);

    result.fold(
      (failure) => _setError(failure.message),
      (roles) {
        _userRoles = roles;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Load all departments
  Future<void> loadDepartments() async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getDepartments();

    result.fold(
      (failure) => _setError(failure.message),
      (depts) {
        _departments = depts;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Load all employees, optionally filtered by job title
  Future<void> loadEmployees({int? jobTitleId}) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getEmployees(jobTitleId: jobTitleId);

    result.fold(
      (failure) => _setError(failure.message),
      (employees) {
        _employees = employees;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Get employees as a Future (for dialogs that can't access provider context)
  Future<List<EmployeeEntity>> getEmployeesFuture({int? jobTitleId}) async {
    final result = await getOrganizationalData.getEmployees(jobTitleId: jobTitleId);
    return result.fold(
      (failure) {
        _setError(failure.message);
        return [];
      },
      (employees) {
        _employees = employees;
        notifyListeners();
        return employees;
      },
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
