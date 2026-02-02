import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/attendance_repository.dart';

class GetAbsensiMenuIDs {
  final AttendanceRepository repository;

  GetAbsensiMenuIDs(this.repository);

  Future<Either<Failure, List<String>>> call(
    int jobTitleId,
    int parentMenuId,
  ) async {
    return await repository.getAbsensiMenuIDs(jobTitleId, parentMenuId);
  }
}
