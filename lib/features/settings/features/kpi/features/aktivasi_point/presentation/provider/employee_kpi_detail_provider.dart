import 'package:flutter/material.dart';
import '../../domain/entities/employee_kpi_entity.dart';
import '../../domain/usecases/get_employee_kpi_by_id.dart';
import '../../domain/usecases/update_employee_kpi_setting.dart';

enum EmployeeKpiDetailStatus { initial, loading, success, error, updating }

/// Provider for the Employee KPI Activation Detail page
class EmployeeKpiDetailProvider extends ChangeNotifier {
  final GetEmployeeKpiById getEmployeeKpiById;
  final UpdateEmployeeKpiSetting updateEmployeeKpiSetting;

  EmployeeKpiDetailProvider({
    required this.getEmployeeKpiById,
    required this.updateEmployeeKpiSetting,
  });

  EmployeeKpiDetailStatus _status = EmployeeKpiDetailStatus.initial;
  String? _errorMessage;
  EmployeeKpi? _employee;
  bool _isKpiActive = false;
  bool _originalIsKpiActive = false;

  // Getters
  EmployeeKpiDetailStatus get status => _status;
  String? get errorMessage => _errorMessage;
  EmployeeKpi? get employee => _employee;
  bool get isKpiActive => _isKpiActive;

  /// Load employee KPI data by employee ID
  Future<void> loadEmployee(int employeeId) async {
    _status = EmployeeKpiDetailStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await getEmployeeKpiById(
      GetEmployeeKpiByIdParams(employeeId: employeeId),
    );

    result.fold(
      (failure) {
        _status = EmployeeKpiDetailStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (employee) {
        _employee = employee;
        _isKpiActive = employee.isKpiActive;
        _originalIsKpiActive = employee.isKpiActive;
        _status = EmployeeKpiDetailStatus.success;
        notifyListeners();
      },
    );
  }

  /// Toggle the KPI activation state
  void toggleKpiActive(bool value) {
    _isKpiActive = value;
    notifyListeners();
  }

  /// Reset to original value
  void resetForm() {
    _isKpiActive = _originalIsKpiActive;
    notifyListeners();
  }

  /// Save the updated KPI activation setting
  Future<bool> save(int employeeId) async {
    _status = EmployeeKpiDetailStatus.updating;
    notifyListeners();

    final result = await updateEmployeeKpiSetting(
      UpdateEmployeeKpiParams(employeeId: employeeId, isActive: _isKpiActive),
    );

    return result.fold(
      (failure) {
        _status = EmployeeKpiDetailStatus.success;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        _originalIsKpiActive = _isKpiActive;
        _status = EmployeeKpiDetailStatus.success;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }
}
