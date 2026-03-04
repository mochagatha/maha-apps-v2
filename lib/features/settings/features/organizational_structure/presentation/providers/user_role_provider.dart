import 'package:flutter/foundation.dart';
import '../../domain/entities/user_role_entity.dart';
import '../../domain/usecases/get_organizational_data.dart';
import '../../domain/usecases/manage_user_role.dart';

/// Provider for managing user role operations
class UserRoleProvider with ChangeNotifier {
  final GetOrganizationalData getOrganizationalData;
  final ManageUserRole manageUserRole;

  UserRoleProvider({
    required this.getOrganizationalData,
    required this.manageUserRole,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<UserRoleEntity> _userRoleHierarchy = [];
  List<UserRoleEntity> get userRoleHierarchy => _userRoleHierarchy;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Load user role hierarchy by type role and optional type branch
  Future<void> loadUserRoleHierarchy(String typeRole, {String? typeBranch}) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getUserRolesByType(typeRole, typeBranch: typeBranch);

    result.fold(
      (failure) {
        _setError(failure.message);
        _userRoleHierarchy = [];
      },
      (roles) {
        _userRoleHierarchy = roles;
      },
    );

    _setLoading(false);
  }

  /// Add a new user role
  Future<bool> addUserRoleData({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageUserRole.addUserRole(
      name: name,
      supervisorRoleId: supervisorRoleId,
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

  /// Update an existing user role
  Future<bool> updateUserRoleData({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageUserRole.updateUserRole(
      id: id,
      name: name,
      supervisorRoleId: supervisorRoleId,
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

  /// Delete a user role
  Future<bool> deleteUserRoleData(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageUserRole.deleteUserRole(id);

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
