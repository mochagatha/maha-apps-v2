import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/screen_security_entity.dart';
import '../../domain/repositories/screen_security_repository.dart';
import '../datasources/screen_security_remote_datasource.dart';

class ScreenSecurityRepositoryImpl implements ScreenSecurityRepository {
  final ScreenSecurityRemoteDataSource remoteDataSource;

  ScreenSecurityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ScreenSecurityEntity>> getScreenSecuritySettings({
    required String type,
    required int employeeWorkerId,
  }) async {
    try {
      final result = await remoteDataSource.getScreenSecuritySettings(
        type: type,
        employeeWorkerId: employeeWorkerId,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}
