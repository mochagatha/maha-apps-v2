import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/employee.dart';
import '../../domain/usecases/get_employee_profile.dart';
import '../../domain/usecases/update_employee_profile.dart';
import '../../domain/usecases/update_profile_picture.dart';

/// Profile status enum
enum ProfileStatus {
  initial,
  loading,
  loaded,
  updating,
  uploadingPicture,
  error,
}

/// Profile provider for state management
class ProfileProvider extends ChangeNotifier {
  final GetEmployeeProfile getEmployeeProfile;
  final UpdateEmployeeProfile updateEmployeeProfile;
  final UpdateProfilePicture updateProfilePicture;

  ProfileProvider({
    required this.getEmployeeProfile,
    required this.updateEmployeeProfile,
    required this.updateProfilePicture,
  });

  // State
  ProfileStatus _status = ProfileStatus.initial;
  Employee? _employee;
  String? _errorMessage;

  // Getters
  ProfileStatus get status => _status;
  Employee? get employee => _employee;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == ProfileStatus.loading;
  bool get isUpdating => _status == ProfileStatus.updating;
  bool get isUploadingPicture => _status == ProfileStatus.uploadingPicture;
  bool get hasError => _status == ProfileStatus.error;

  /// Load employee profile
  Future<void> loadProfile() async {
    _status = ProfileStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await getEmployeeProfile(NoParams());

    result.fold(
      (failure) {
        _status = ProfileStatus.error;
        _errorMessage = failure.message;
      },
      (employee) {
        _status = ProfileStatus.loaded;
        _employee = employee;
      },
    );

    notifyListeners();
  }

  /// Update employee profile
  Future<bool> updateProfile({
    String? phone,
    String? address,
    String? emergencyContact,
    String? emergencyPhone,
  }) async {
    _status = ProfileStatus.updating;
    _errorMessage = null;
    notifyListeners();

    final params = UpdateProfileParams(
      phone: phone,
      address: address,
      emergencyContact: emergencyContact,
      emergencyPhone: emergencyPhone,
    );

    final result = await updateEmployeeProfile(params);

    return result.fold(
      (failure) {
        _status = ProfileStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (employee) {
        _status = ProfileStatus.loaded;
        _employee = employee;
        notifyListeners();
        return true;
      },
    );
  }

  /// Upload profile picture
  Future<bool> uploadProfilePicture(File image) async {
    _status = ProfileStatus.uploadingPicture;
    _errorMessage = null;
    notifyListeners();

    final params = UpdateProfilePictureParams(image: image);
    final result = await updateProfilePicture(params);

    return result.fold(
      (failure) {
        _status = ProfileStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (photoUrl) {
        // Update employee with new photo URL
        if (_employee != null) {
          _employee = Employee(
            id: _employee!.id,
            fullname: _employee!.fullname,
            nik: _employee!.nik,
            email: _employee!.email,
            photoUrl: photoUrl,
            phone: _employee!.phone,
            jobTitleId: _employee!.jobTitleId,
            jobTitle: _employee!.jobTitle,
            departmentCode: _employee!.departmentCode,
            department: _employee!.department,
            branchCode: _employee!.branchCode,
            branch: _employee!.branch,
            status: _employee!.status,
            type: _employee!.type,
            totalPoint: _employee!.totalPoint,
            biodata: _employee!.biodata,
          );
        }
        _status = ProfileStatus.loaded;
        notifyListeners();
        return true;
      },
    );
  }

  /// Refresh profile data
  Future<void> refresh() async {
    await loadProfile();
  }
}
