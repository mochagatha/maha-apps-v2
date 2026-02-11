import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/kpi.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/notification_count.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_local_datasource.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Employee>> getEmployeeProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final employeeModel = await remoteDataSource.getEmployeeProfile();

        // Cache the employee profile
        await localDataSource.cacheEmployeeProfile(employeeModel);

        return Right(employeeModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // Try to get from cache when offline
      try {
        final cachedEmployee = await localDataSource.getCachedEmployeeProfile();
        if (cachedEmployee != null) {
          return Right(cachedEmployee.toEntity());
        } else {
          return Left(CacheFailure('No cached employee data available'));
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      } on Exception catch (e) {
        return Left(CacheFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<MenuItem>>> getEmployeeMenus() async {
    if (await networkInfo.isConnected) {
      try {
        final menuModels = await remoteDataSource.getEmployeeMenus();

        return Right(menuModels.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MenuItem>>> getAdminMenus() async {
    if (await networkInfo.isConnected) {
      try {
        final menuModels = await remoteDataSource.getAdminMenus();

        return Right(menuModels.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, List<MenuItem>>> getHierarchicalMenus() async {
    if (await networkInfo.isConnected) {
      try {
        final menuModels = await remoteDataSource.getHierarchicalMenus();

        return Right(menuModels.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, NotificationCount>> getNotificationCount() async {
    if (await networkInfo.isConnected) {
      try {
        final notificationModel = await remoteDataSource.getNotificationCount();
        return Right(notificationModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }

  @override
  Future<Either<Failure, Kpi>> getKpiSummary({required int month, required int year}) async {
    if (await networkInfo.isConnected) {
      try {
        final kpiModel = await remoteDataSource.getKpiSummary(month: month, year: year);
        return Right(kpiModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } on Exception catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return Left(NetworkFailure('No internet connection'));
    }
  }
}
