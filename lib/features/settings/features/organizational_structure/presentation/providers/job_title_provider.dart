import 'package:flutter/foundation.dart';
import '../../domain/entities/job_title_entity.dart';
import '../../domain/usecases/get_organizational_data.dart';
import '../../domain/usecases/manage_job_title.dart';

/// Provider for managing job title operations
class JobTitleProvider with ChangeNotifier {
  final GetOrganizationalData getOrganizationalData;
  final ManageJobTitle manageJobTitle;

  JobTitleProvider({
    required this.getOrganizationalData,
    required this.manageJobTitle,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<JobTitleEntity> _jobTitles = [];
  List<JobTitleEntity> get jobTitles => _jobTitles;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Load job titles by type role and branch
  Future<void> loadJobTitles({
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await getOrganizationalData.getJobTitles(
      typeRole: typeRole,
      typeBranch: typeBranch,
    );

    result.fold(
      (failure) => _setError(failure.message),
      (titles) {
        _jobTitles = titles;
        notifyListeners();
      },
    );

    _setLoading(false);
  }

  /// Add a new job title
  Future<bool> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageJobTitle.addJobTitle(
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

  /// Update an existing job title
  Future<bool> updateJobTitle({
    required int id,
    required String name,
  }) async {
    _setLoading(true);
    _setError(null);

    final result = await manageJobTitle.updateJobTitle(id: id, name: name);

    _setLoading(false);

    return result.fold(
      (failure) {
        _setError(failure.message);
        return false;
      },
      (_) => true,
    );
  }

  /// Delete a job title
  Future<bool> deleteJobTitle(int id) async {
    _setLoading(true);
    _setError(null);

    final result = await manageJobTitle.deleteJobTitle(id);

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
