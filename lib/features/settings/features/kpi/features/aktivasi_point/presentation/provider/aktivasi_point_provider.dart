import 'package:flutter/material.dart';

enum AktivasiPointStatus { initial, loading, success, error, updating }

/// Model for employee in activation point
class EmployeeActivation {
  final String id;
  final String name;
  final String jobTitle;
  final String? avatarUrl;
  bool isActive;

  EmployeeActivation({
    required this.id,
    required this.name,
    required this.jobTitle,
    this.avatarUrl,
    this.isActive = false,
  });

  EmployeeActivation copyWith({
    String? id,
    String? name,
    String? jobTitle,
    String? avatarUrl,
    bool? isActive,
  }) {
    return EmployeeActivation(
      id: id ?? this.id,
      name: name ?? this.name,
      jobTitle: jobTitle ?? this.jobTitle,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isActive: isActive ?? this.isActive,
    );
  }
}

class AktivasiPointProvider extends ChangeNotifier {
  AktivasiPointStatus _status = AktivasiPointStatus.initial;
  String? _errorMessage;
  bool _isMainActivationEnabled = false;
  List<EmployeeActivation> _employees = [];
  List<EmployeeActivation> _originalEmployees = [];

  // Getters
  AktivasiPointStatus get status => _status;
  String? get errorMessage => _errorMessage;
  bool get isMainActivationEnabled => _isMainActivationEnabled;
  List<EmployeeActivation> get employees => _employees;

  /// Load activation point settings
  Future<void> loadActivationSettings() async {
    try {
      _status = AktivasiPointStatus.loading;
      notifyListeners();

      // TODO: Replace with actual API call when domain/data layers are ready
      // For now, using mock data
      await Future.delayed(const Duration(milliseconds: 500));

      _employees = [
        EmployeeActivation(
          id: '1',
          name: 'Ulli Ambri',
          jobTitle: 'UIUX Designer',
          isActive: true,
        ),
        EmployeeActivation(
          id: '2',
          name: 'Setia Putera',
          jobTitle: 'IT Governance',
          isActive: false,
        ),
        EmployeeActivation(
          id: '3',
          name: 'T Rizaldi Fadli',
          jobTitle: 'IT Governance',
          isActive: false,
        ),
        EmployeeActivation(
          id: '4',
          name: 'Arif Firmansyah',
          jobTitle: 'IT Programmer',
          isActive: false,
        ),
        EmployeeActivation(
          id: '5',
          name: 'Syaiful Anwar',
          jobTitle: 'IT Governance',
          isActive: false,
        ),
      ];

      _originalEmployees = _employees.map((e) => e.copyWith(isActive: e.isActive)).toList();

      _isMainActivationEnabled = true;

      _status = AktivasiPointStatus.success;
      _errorMessage = null;
      notifyListeners();
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

  /// Toggle individual employee activation
  void toggleEmployeeActivation(String employeeId, bool value) {
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

      // TODO: Replace with actual API call when domain/data layers are ready
      await Future.delayed(const Duration(seconds: 1));

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
