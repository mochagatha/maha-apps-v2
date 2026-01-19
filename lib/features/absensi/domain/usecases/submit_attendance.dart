import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class SubmitAttendance {
  final AttendanceRepository repository;

  SubmitAttendance(this.repository);

  Future<Either<Failure, String>> call({
    required int employeeId,
    required String attendanceDate,
    required String attendanceTime,
    required String attendanceLocation,
    required String attendancePhotoPath,
    required String attendanceBranch,
    required int status,
    bool isWorker = false,
  }) async {
    return await repository.submitAttendance(
      employeeId: employeeId,
      attendanceDate: attendanceDate,
      attendanceTime: attendanceTime,
      attendanceLocation: attendanceLocation,
      attendancePhotoPath: attendancePhotoPath,
      attendanceBranch: attendanceBranch,
      status: status,
      isWorker: isWorker,
    );
  }
}
