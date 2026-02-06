import 'package:flutter/foundation.dart';
import '../../../organizational_structure/domain/entities/employee_entity.dart';
import '../../../organizational_structure/domain/usecases/get_organizational_data.dart';

/// Provider for managing employee list state
class EmployeeListProvider extends ChangeNotifier {
  final GetOrganizationalData getOrganizationalData;

  EmployeeListProvider({required this.getOrganizationalData});

  List<EmployeeEntity> _employees = [];
  List<EmployeeEntity> _filteredEmployees = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';

  List<EmployeeEntity> get employees => _employees;
  List<EmployeeEntity> get filteredEmployees => _filteredEmployees;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load all employees
  Future<void> loadEmployees() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getOrganizationalData.getEmployees();

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isLoading = false;
        notifyListeners();
      },
      (employees) {
        _employees = employees;
        _filteredEmployees = employees;
        _isLoading = false;
        _applySearch();
        notifyListeners();
      },
    );
  }

  /// Search employees by name
  void searchEmployees(String query) {
    _searchQuery = query;
    _applySearch();
    notifyListeners();
  }

  void _applySearch() {
    if (_searchQuery.isEmpty) {
      _filteredEmployees = _employees;
    } else {
      final queryLower = _searchQuery.toLowerCase();
      _filteredEmployees = _employees.where((employee) {
        return employee.fullname.toLowerCase().contains(queryLower);
      }).toList();
    }
  }

  /// Clear all data
  void clear() {
    _employees = [];
    _filteredEmployees = [];
    _searchQuery = '';
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
