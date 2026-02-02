import 'package:flutter/foundation.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/usecases/get_organizational_data.dart';
import '../../domain/usecases/manage_department.dart';

/// Provider for managing department operations
class DepartmentProvider with ChangeNotifier {
  final GetOrganizationalData getOrganizationalData;
  final ManageDepartment manageDepartment;

  DepartmentProvider({
    required this.getOrganizationalData,
    required this.manageDepartment,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<DepartmentEntity> _departments = [];
  List<DepartmentEntity> get departments => _departments;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
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

  /// Load departments by type role and branch
  Future<void> loadDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getDepartmentsByType(
      typeRole: typeRole,
      typeBranch: typeBranch,
    );

    result.fold(
      (failure) => _setError(failure.message),
      (depts) {
        _departments = depts;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Add a new department
  Future<bool> addDepartmentData({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageDepartment.addDepartment(
      name: name,
      typeRole: typeRole,
      typeBranch: typeBranch,
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

  /// Update an existing department
  Future<bool> updateDepartmentData({
    required int id,
    required String name,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageDepartment.updateDepartment(id: id, name: name);

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Delete a department
  Future<bool> deleteDepartmentData(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageDepartment.deleteDepartment(id);

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
