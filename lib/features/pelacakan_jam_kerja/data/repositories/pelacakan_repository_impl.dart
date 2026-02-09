import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/tracking_employee.dart';
import '../../domain/entities/tracking_settings.dart';
import '../../domain/repositories/pelacakan_repository.dart';
import '../datasources/pelacakan_local_data_source.dart';
import '../datasources/pelacakan_remote_data_source.dart';

class PelacakanRepositoryImpl implements PelacakanRepository {
  final PelacakanRemoteDataSource remoteDataSource;
  final PelacakanLocalDataSource localDataSource;

  PelacakanRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, TrackingSettings>> getTrackingSettings(
    String employeeType,
  ) async {
    try {
      final settings = await remoteDataSource.getTrackingSettings(employeeType);
      await localDataSource.cacheSettings(settings);
      return Right(settings);
    } on DioException catch (e) {
      // Try to get cached data if network request fails
      final cachedSettings = await localDataSource.getCachedSettings(employeeType);
      if (cachedSettings != null) {
        return Right(cachedSettings);
      }

      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<TrackingEmployee>>> getEmployees(
    String employeeType,
  ) async {
    try {
      final employees = await remoteDataSource.getEmployees(employeeType);
      return Right(employees);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGlobalTracking({
    required String employeeType,
    required bool isEnabled,
  }) async {
    try {
      await remoteDataSource.saveTrackingSettings(
        employeeType: employeeType,
        isGlobalEnabled: isEnabled,
        enabledEmployeeIds: [],
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployeeTracking({
    required int employeeId,
    required bool isEnabled,
  }) async {
    // This is typically handled in saveTrackingSettings
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> saveTrackingSettings({
    required String employeeType,
    required bool isGlobalEnabled,
    required List<int> enabledEmployeeIds,
  }) async {
    try {
      await remoteDataSource.saveTrackingSettings(
        employeeType: employeeType,
        isGlobalEnabled: isGlobalEnabled,
        enabledEmployeeIds: enabledEmployeeIds,
      );
      await localDataSource.clearCache();
      return const Right(null);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Bad certificate');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401) {
          return const ServerFailure('Unauthorized');
        } else if (statusCode == 404) {
          return const ServerFailure('Endpoint not found');
        }
        return ServerFailure(
          e.response?.data['message'] ?? 'Server error occurred',
        );
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      case DioExceptionType.unknown:
        return const NetworkFailure('Unknown error occurred');
    }
  }
}
