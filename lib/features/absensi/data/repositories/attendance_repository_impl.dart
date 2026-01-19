import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/attendance_today.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../datasources/attendance_remote_datasource.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  AttendanceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AttendanceToday>> getTodayAttendance(
    int employeeId, {
    bool isWorker = false,
  }) async {
    try {
      final result = await remoteDataSource.getTodayAttendance(
        employeeId,
        isWorker: isWorker,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getAbsensiMenuIDs(
    int jobTitleId,
    int parentMenuId,
  ) async {
    try {
      final result = await remoteDataSource.getAbsensiMenuIDs(
        jobTitleId,
        parentMenuId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
