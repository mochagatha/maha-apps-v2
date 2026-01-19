import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_today.dart';

abstract class AttendanceRepository {
  /// Get today's attendance data for the employee
  /// [isWorker] determines if the worker endpoint should be used
  Future<Either<Failure, AttendanceToday>> getTodayAttendance(int employeeId, {bool isWorker = false});

  /// Get allowed menu IDs for the abstract feature based on job title
  Future<Either<Failure, List<String>>> getAbsensiMenuIDs(int jobTitleId, int parentMenuId);
  
  /// Submit attendance with photo and location
  Future<Either<Failure, String>> submitAttendance({
    required int employeeId,
    required String attendanceDate,
    required String attendanceTime,
    required String attendanceLocation,
    required String attendancePhotoPath,
    required String attendanceBranch,
    required int status,
    bool isWorker = false,
  });
}
