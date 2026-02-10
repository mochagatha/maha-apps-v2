import 'package:flutter/material.dart';
import '../../domain/entities/tracking_employee.dart';
import '../../domain/entities/tracking_settings.dart';
import '../../domain/usecases/get_employees.dart';
import '../../domain/usecases/get_tracking_settings.dart';
import '../../domain/usecases/save_tracking_settings.dart';

enum PelacakanStatus { initial, loading, success, error }

class PelacakanProvider extends ChangeNotifier {
  final GetTrackingSettings _getTrackingSettings;
  final GetEmployees _getEmployees;
  final SaveTrackingSettings _saveTrackingSettings;

  PelacakanProvider({
    required GetTrackingSettings getTrackingSettings,
    required GetEmployees getEmployees,
    required SaveTrackingSettings saveTrackingSettings,
  }) : _getTrackingSettings = getTrackingSettings,
       _getEmployees = getEmployees,
       _saveTrackingSettings = saveTrackingSettings;

  PelacakanStatus _status = PelacakanStatus.initial;
  PelacakanStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  TrackingSettings? _settings;
  TrackingSettings? get settings => _settings;

  List<TrackingEmployee> _employees = [];
  List<TrackingEmployee> get employees => _employees;

  List<TrackingEmployee> _filteredEmployees = [];
  List<TrackingEmployee> get filteredEmployees => _filteredEmployees;

  bool _isGlobalEnabled = false;
  bool get isGlobalEnabled => _isGlobalEnabled;

  String _currentEmployeeType = 'karyawan';
  String get currentEmployeeType => _currentEmployeeType;

  bool _isSaving = false;
  bool get isSaving => _isSaving;

  void setEmployeeType(String type) {
    _currentEmployeeType = type;
    notifyListeners();
  }

  Future<void> loadTrackingData(String employeeType) async {
    _status = PelacakanStatus.loading;
    _currentEmployeeType = employeeType;
    _errorMessage = null;
    notifyListeners();

    // Load settings
    final settingsResult = await _getTrackingSettings(
      TrackingSettingsParams(employeeType: employeeType),
    );

    settingsResult.fold(
      (failure) {
        _status = PelacakanStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (settings) {
        _settings = settings;
        _isGlobalEnabled = settings.isGlobalTrackingEnabled;
      },
    );

    // Load employees
    final employeesResult = await _getEmployees(
      EmployeesParams(employeeType: employeeType),
    );

    employeesResult.fold(
      (failure) {
        _status = PelacakanStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (employees) {
        _employees = employees;
        _filteredEmployees = employees;
        _status = PelacakanStatus.success;
        notifyListeners();
      },
    );
  }

  void toggleGlobalTracking(bool value) {
    _isGlobalEnabled = value;
    notifyListeners();
  }

  void toggleEmployeeTracking(int employeeId, bool value) {
    final index = _employees.indexWhere((e) => e.id == employeeId);
    if (index != -1) {
      _employees[index] = _employees[index].copyWith(isTrackingEnabled: value);

      // Update filtered list
      final filteredIndex = _filteredEmployees.indexWhere((e) => e.id == employeeId);
      if (filteredIndex != -1) {
        _filteredEmployees[filteredIndex] = _filteredEmployees[filteredIndex].copyWith(
          isTrackingEnabled: value,
        );
      }

      notifyListeners();
    }
  }

  void filterEmployees(String query) {
    if (query.isEmpty) {
      _filteredEmployees = _employees;
    } else {
      _filteredEmployees = _employees
          .where(
            (employee) =>
                employee.fullname.toLowerCase().contains(query.toLowerCase()) ||
                employee.jobTitleName.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  Future<bool> saveSettings() async {
    _isSaving = true;
    _errorMessage = null;
    notifyListeners();

    final enabledEmployeeIds = _employees
        .where((e) => e.isTrackingEnabled)
        .map((e) => e.id)
        .toList();

    final result = await _saveTrackingSettings(
      SaveTrackingParams(
        employeeType: _currentEmployeeType,
        isGlobalEnabled: _isGlobalEnabled,
        enabledEmployeeIds: enabledEmployeeIds,
      ),
    );

    _isSaving = false;

    return result.fold(
      (failure) {
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (_) {
        notifyListeners();
        return true;
      },
    );
  }

  void reset() {
    _status = PelacakanStatus.initial;
    _errorMessage = null;
    _settings = null;
    _employees = [];
    _filteredEmployees = [];
    _isGlobalEnabled = false;
    _isSaving = false;
    notifyListeners();
  }
}
