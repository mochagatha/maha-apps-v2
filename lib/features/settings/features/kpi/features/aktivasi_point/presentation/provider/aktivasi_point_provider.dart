import 'package:flutter/material.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../../domain/entities/employee_kpi_entity.dart';
import '../../domain/usecases/get_kpi_settings.dart';
import '../../domain/usecases/update_global_kpi_setting.dart';
import '../../domain/usecases/update_employee_kpi_setting.dart';

enum AktivasiPointStatus { initial, loading, success, error, updating }

/// Model for employee in activation point
class EmployeeActivation {
  final int id;
  final String nik;
  final String name;
  final String jobTitle;
  final String? avatarUrl;
  final String statusLabel;
  final String departmentName;
  bool isActive;

  EmployeeActivation({
    required this.id,
    required this.nik,
    required this.name,
    required this.jobTitle,
    this.avatarUrl,
    required this.statusLabel,
    required this.departmentName,
    this.isActive = false,
  });

  factory EmployeeActivation.fromEntity(EmployeeKpi entity) {
    return EmployeeActivation(
      id: entity.id,
      nik: entity.nik,
      name: entity.fullname,
      jobTitle: entity.jobTitle,
      avatarUrl: entity.photoUrl,
      statusLabel: entity.statusLabel,
      departmentName: entity.departmentName,
      isActive: entity.isKpiActive,
    );
  }

  EmployeeActivation copyWith({
    int? id,
    String? nik,
    String? name,
    String? jobTitle,
    String? avatarUrl,
    String? statusLabel,
    String? departmentName,
    bool? isActive,
  }) {
    return EmployeeActivation(
      id: id ?? this.id,
      nik: nik ?? this.nik,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      statusLabel: statusLabel ?? this.statusLabel,
      departmentName: departmentName ?? this.departmentName,
      isActive: isActive ?? this.isActive,
    );
  }
}

class AktivasiPointProvider extends ChangeNotifier {
  final GetKpiSettings getKpiSettings;
  final UpdateGlobalKpiSetting updateGlobalKpiSetting;
  final UpdateEmployeeKpiSetting updateEmployeeKpiSetting;

  AktivasiPointProvider({
    required this.getKpiSettings,
    required this.updateGlobalKpiSetting,
    required this.updateEmployeeKpiSetting,
  });

  AktivasiPointStatus _status = AktivasiPointStatus.initial;
  String? _errorMessage;
  bool _isMainActivationEnabled = false;
  String _searchQuery = '';
  List<EmployeeActivation> _employees = [];
  List<EmployeeActivation> _originalEmployees = [];

  // Getters
  AktivasiPointStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isMainActivationEnabled => _isMainActivationEnabled;
  String get searchQuery => _searchQuery;
  List<EmployeeActivation> get employees => _employees;
  List<EmployeeActivation> get filteredEmployees {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) {
      return _employees;
    }

    return _employees.where((employee) {
      return employee.name.toLowerCase().contains(query) ||
          employee.nik.toLowerCase().contains(query) ||
          employee.jobTitle.toLowerCase().contains(query);
    }).toList();
  }

  /// Load activation point settings
  Future<void> loadActivationSettings() async {
    try {
      _status = AktivasiPointStatus.loading;
      notifyListeners();

      // Call API through use case
      final result = await getKpiSettings(NoParams());

      result.fold(
        (failure) {
          _status = AktivasiPointStatus.error;
          _errorMessage = failure.message;
          notifyListeners();
        },
        (kpiSettings) {
          _employees = kpiSettings.employees.map((e) => EmployeeActivation.fromEntity(e)).toList();

          _originalEmployees = _employees.map((e) => e.copyWith(isActive: e.isActive)).toList();

          _isMainActivationEnabled = kpiSettings.isActive;

          _status = AktivasiPointStatus.success;
          _errorMessage = null;
          notifyListeners();
        },
      );
    } catch (e) {
      _status = AktivasiPointStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  /// Toggle main activation
  void toggleMainActivation(bool value) {
    _isMainActivationEnabled = value;
    notifyListeners();
  }

  /// Update search query for employee filtering
  void setSearchQuery(String value) {
    if (_searchQuery == value) {
      return;
    }
    _searchQuery = value;
    notifyListeners();
  }

  /// Toggle individual employee activation
  void toggleEmployeeActivation(int employeeId, bool value) {
    final index = _employees.indexWhere((e) => e.id == employeeId);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(isActive: value);
      notifyListeners();
    }
  }

  /// Reset form to original values
  void resetForm() {
    _employees = _originalEmployees.map((e) => e.copyWith(isActive: e.isActive)).toList();
    notifyListeners();
  }

  /// Save activation settings
  Future<bool> saveSettings() async {
    try {
      _status = AktivasiPointStatus.updating;
      notifyListeners();

      // First, update global setting
      final globalResult = await updateGlobalKpiSetting(
        UpdateGlobalKpiParams(isActive: _isMainActivationEnabled),
      );

      // Check if global update failed
      final globalSuccess = globalResult.fold(
        (failure) {
          _status = AktivasiPointStatus.error;
          _errorMessage = failure.message;
          notifyListeners();
          return false;
        },
        (_) => true,
      );

      if (!globalSuccess) {
        return false;
      }

      // Then, update individual employee settings that changed
      for (var i = 0; i < _employees.length; i++) {
        final employee = _employees[i];
        final original = _originalEmployees.firstWhere(
          (e) => e.id == employee.id,
          orElse: () => employee,
        );

        // Only update if the value changed
        if (employee.isActive != original.isActive) {
          final employeeResult = await updateEmployeeKpiSetting(
            UpdateEmployeeKpiParams(
              employeeId: employee.id,
              isActive: employee.isActive,
            ),
          );

          // Check if employee update failed
          final employeeSuccess = employeeResult.fold(
            (failure) {
              _status = AktivasiPointStatus.error;
              _errorMessage = failure.message;
              notifyListeners();
              return false;
            },
            (_) => true,
          );

          if (!employeeSuccess) {
            return false;
          }
        }
      }

      // Update original values after successful save
      _originalEmployees = _employees.map((e) => e.copyWith(isActive: e.isActive)).toList();

      _status = AktivasiPointStatus.success;
      _errorMessage = null;
      notifyListeners();
      return true;
    } catch (e) {
      _status = AktivasiPointStatus.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
