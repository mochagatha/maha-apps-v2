import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../datasources/access_screen_remote_datasource.dart';
import '../../domain/entities/access_screen_entity.dart';
import '../../domain/repositories/access_screen_repository.dart';
import 'package:dio/dio.dart';

class AccessScreenRepositoryImpl implements AccessScreenRepository {
  final AccessScreenRemoteDataSource remoteDataSource;

  AccessScreenRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AccessScreenGlobalEntity>> getAccessScreenList(String type) async {
    try {
      final result = await remoteDataSource.getAccessScreenList(type);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AccessScreenDetailEntity>> getAccessScreenDetail(
    String type,
    int id,
  ) async {
    try {
      final result = await remoteDataSource.getAccessScreenDetail(type, id);
      return Right(result);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGlobalAccessScreen(
    int id,
    bool isRecord,
    bool isCatch,
  ) async {
    try {
      await remoteDataSource.updateGlobalAccessScreen(id, isRecord, isCatch);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDetailAccessScreen(
    int id,
    bool isRecord,
    bool isCatch,
  ) async {
    try {
      await remoteDataSource.updateDetailAccessScreen(id, isRecord, isCatch);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.message ?? 'Unknown error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
