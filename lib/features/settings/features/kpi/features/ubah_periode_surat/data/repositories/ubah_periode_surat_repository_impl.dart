import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../../../core/error/exceptions.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../domain/entities/punishment_setting.dart';
import '../../domain/repositories/ubah_periode_surat_repository.dart';
import '../datasources/ubah_periode_surat_remote_data_source.dart';

class UbahPeriodeSuratRepositoryImpl implements UbahPeriodeSuratRepository {
  final UbahPeriodeSuratRemoteDataSource remoteDataSource;

  UbahPeriodeSuratRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PunishmentSetting>> getPunishmentSetting() async {
    try {
      final setting = await remoteDataSource.getPunishmentSetting();
      return Right(setting);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PunishmentSetting>> updatePunishmentSetting({
    required bool isActive,
    required int longPunishment,
    required bool loanPoint,
  }) async {
    try {
      final setting = await remoteDataSource.updatePunishmentSetting(
        isActive: isActive,
        longPunishment: longPunishment,
        loanPoint: loanPoint,
      );
      return Right(setting);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } on ServerException {
      return const Left(ServerFailure('Server error occurred'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Failure _handleDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
      return const NetworkFailure('Connection timeout');
    }

    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final message = e.response!.data['message'] ?? 'An error occurred';

      if (statusCode != null && statusCode >= 500) {
        return ServerFailure('Server error: $message');
      }
      return ServerFailure(message);
    }

    return const NetworkFailure('No internet connection');
  }
}
