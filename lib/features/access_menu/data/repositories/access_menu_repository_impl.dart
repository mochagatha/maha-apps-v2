import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/menu_access_entity.dart';
import '../../domain/repositories/access_menu_repository.dart';
import '../datasources/access_menu_remote_data_source.dart';

/// Implementation of AccessMenuRepository
class AccessMenuRepositoryImpl implements AccessMenuRepository {
  final AccessMenuRemoteDataSource remoteDataSource;

  AccessMenuRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MenuAccessEntity>>> getEmployeeMenus(
    int employeeId,
  ) async {
    try {
      final result = await remoteDataSource.getEmployeeMenus(employeeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MenuAccessEntity>>> getAllMenus() async {
    try {
      final result = await remoteDataSource.getAllMenus();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    try {
      await remoteDataSource.createEmployeeMenus(
        employeeId: employeeId,
        menuIds: menuIds,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    try {
      await remoteDataSource.deleteEmployeeMenus(
        employeeId: employeeId,
        menuIds: menuIds,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
