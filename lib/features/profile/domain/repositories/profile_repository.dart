import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';

/// Profile repository interface
/// Defines the contract for profile-related operations
abstract class ProfileRepository {
  /// Get the current employee profile
  Future<Either<Failure, Employee>> getProfile();

  /// Update employee profile
  /// Returns the updated employee data
  Future<Either<Failure, Employee>> updateProfile(Map<String, dynamic> params);

  /// Update profile picture
  /// Returns the URL of the uploaded image
  Future<Either<Failure, String>> updateProfilePicture(File image);
}
