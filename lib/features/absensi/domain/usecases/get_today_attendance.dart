import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/attendance_today.dart';
import '../repositories/attendance_repository.dart';

class GetTodayAttendance {
  final AttendanceRepository repository;

  GetTodayAttendance(this.repository);

  Future<Either<Failure, AttendanceToday>> call(
    int employeeId, {
    bool isWorker = false,
  }) async {
    return await repository.getTodayAttendance(employeeId, isWorker: isWorker);
  }
}
