import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../profile/domain/entities/employee.dart';
import '../../../profile/domain/usecases/get_employee_profile.dart';

enum BiodataStatus { initial, loading, loaded, error }

class BiodataProvider extends ChangeNotifier {
  final GetEmployeeProfile getEmployeeProfile;

  BiodataProvider({
    required this.getEmployeeProfile,
  });

  BiodataStatus _status = BiodataStatus.initial;
  Employee? _employee;
  String? _errorMessage;

  BiodataStatus get status => _status;
  Employee? get employee => _employee;
  String? get errorMessage => _errorMessage;

  Future<void> loadEmployeeData() async {
    _status = BiodataStatus.loading;
    notifyListeners();

    final result = await getEmployeeProfile(NoParams());

    result.fold(
      (failure) {
        _status = BiodataStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (employee) {
        _status = BiodataStatus.loaded;
        _employee = employee;
        notifyListeners();
      },
    );
  }
}
