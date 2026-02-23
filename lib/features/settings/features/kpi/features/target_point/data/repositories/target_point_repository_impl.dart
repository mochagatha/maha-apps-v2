import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../domain/entities/target_point_indicator.dart';
import '../../domain/repositories/target_point_repository.dart';
import '../datasources/target_point_remote_datasource.dart';

/// Implementation of TargetPointRepository
class TargetPointRepositoryImpl implements TargetPointRepository {
  final TargetPointRemoteDataSource remoteDataSource;

  TargetPointRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<TargetPointIndicator>>> getTargetPointIndicators() async {
    try {
      final indicators = await remoteDataSource.getTargetPointIndicators();
      return Right(indicators.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? 'Network error occurred',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateTargetPointIndicator({
    required int id,
    required int value,
  }) async {
    try {
      await remoteDataSource.updateTargetPointIndicator(id: id, value: value);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['message'] ?? 'Network error occurred',
        ),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
