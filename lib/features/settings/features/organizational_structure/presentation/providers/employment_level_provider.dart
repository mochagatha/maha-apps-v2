import 'package:flutter/foundation.dart';
import '../../domain/entities/employment_level_entity.dart';
import '../../domain/usecases/get_organizational_data.dart';
import '../../domain/usecases/manage_employment_level.dart';

/// Provider for managing employment level operations
class EmploymentLevelProvider with ChangeNotifier {
  final GetOrganizationalData getOrganizationalData;
  final ManageEmploymentLevel manageEmploymentLevel;

  EmploymentLevelProvider({
    required this.getOrganizationalData,
    required this.manageEmploymentLevel,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<EmploymentLevelEntity> _employmentLevels = [];
  List<EmploymentLevelEntity> get employmentLevels => _employmentLevels;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Load employment levels by type role
  Future<void> loadEmploymentLevelsByType({required String typeRole}) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getEmploymentLevelsByType(typeRole: typeRole);

    result.fold(
      (failure) {
        _setError(failure.message);
        _employmentLevels = [];
      },
      (employmentLevels) {
        _employmentLevels = employmentLevels;
      },
    );

    _setLoading(false);
  }

  /// Add a new employment level
  Future<bool> addEmploymentLevelData({required String name, required String typeRole}) async {
    _setLoading(true);
    _setError(null);

    final result = await manageEmploymentLevel.addEmploymentLevel(name: name, typeRole: typeRole);

    _setLoading(false);

    return result.fold((failure) {
      _setError(failure.message);
      return false;
    }, (_) => true);
  }

  /// Update an existing employment level
  Future<bool> updateEmploymentLevelData({required int id, required String name}) async {
    _setLoading(true);
    _setError(null);

    final result = await manageEmploymentLevel.updateEmploymentLevel(id: id, name: name);

    _setLoading(false);

    return result.fold((failure) {
      _setError(failure.message);
      return false;
    }, (_) => true);
  }

  /// Delete an employment level
  Future<bool> deleteEmploymentLevelData(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageEmploymentLevel.deleteEmploymentLevel(id);

    _setLoading(false);

    return result.fold((failure) {
      _setError(failure.message);
      return false;
    }, (_) => true);
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
