import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/tracking_employee.dart';
import '../entities/tracking_settings.dart';

/// Repository interface for Pelacakan Jam Kerja feature
abstract class PelacakanRepository {
  /// Get tracking settings for a specific employee type
  Future<Either<Failure, TrackingSettings>> getTrackingSettings(
    String employeeType,
  );

  /// Update global tracking settings
  Future<Either<Failure, void>> updateGlobalTracking({
    required String employeeType,
    required bool isEnabled,
  });

  /// Get list of employees for tracking management
  Future<Either<Failure, List<TrackingEmployee>>> getEmployees(
    String employeeType,
  );

  /// Update individual employee tracking setting
  Future<Either<Failure, void>> updateEmployeeTracking({
    required int employeeId,
    required bool isEnabled,
  });

  /// Save all tracking settings
  Future<Either<Failure, void>> saveTrackingSettings({
    required String employeeType,
    required bool isGlobalEnabled,
    required List<int> enabledEmployeeIds,
  });
}
