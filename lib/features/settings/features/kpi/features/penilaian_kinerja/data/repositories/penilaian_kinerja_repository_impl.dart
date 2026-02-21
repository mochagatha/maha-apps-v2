import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../../../../core/error/exceptions.dart';
import '../../../../../../../../../core/error/failures.dart';
import '../../domain/entities/kpi_indicators_data.dart';
import '../../domain/repositories/penilaian_kinerja_repository.dart';
import '../datasources/penilaian_kinerja_remote_data_source.dart';

class PenilaianKinerjaRepositoryImpl implements PenilaianKinerjaRepository {
  final PenilaianKinerjaRemoteDataSource remoteDataSource;

  PenilaianKinerjaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, KpiIndicatorsData>> getKpiIndicators() async {
    try {
      final result = await remoteDataSource.getKpiIndicators();
      return Right(
        KpiIndicatorsData(
          attendance: result.attendance.map((m) => m.toEntity()).toList(),
          supervisorAssessment: result.supervisorAssessment.map((m) => m.toEntity()).toList(),
          targetPoint: result.targetPoint.map((m) => m.toEntity()).toList(),
          task: result.task.map((m) => m.toEntity()).toList(),
          workPlan: result.workPlan.map((m) => m.toEntity()).toList(),
        ),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data['message'] ?? 'Network error occurred'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateManyKpiIndicators(
    List<KpiIndicatorUpdateItem> items,
  ) async {
    try {
      await remoteDataSource.updateManyKpiIndicators(
        items.map((e) => {'id': e.id, 'value': e.value}).toList(),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data['message'] ?? 'Network error occurred'),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
