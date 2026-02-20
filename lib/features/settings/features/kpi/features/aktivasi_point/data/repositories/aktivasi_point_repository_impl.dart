import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../domain/entities/employee_kpi_entity.dart';
import '../../domain/entities/kpi_settings_entity.dart';
import '../../domain/repositories/aktivasi_point_repository.dart';
import '../datasources/aktivasi_point_remote_data_source.dart';

/// Implementation of AktivasiPointRepository
class AktivasiPointRepositoryImpl implements AktivasiPointRepository {
  final AktivasiPointRemoteDataSource remoteDataSource;

  AktivasiPointRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, KpiSettings>> getKpiSettings() async {
    try {
      final kpiSettingsModel = await remoteDataSource.getKpiSettings();
      return Right(kpiSettingsModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, EmployeeKpi>> getEmployeeKpiById(int employeeId) async {
    try {
      final model = await remoteDataSource.getEmployeeKpiById(employeeId);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateGlobalKpiSetting({
    required bool isActive,
  }) async {
    try {
      await remoteDataSource.updateGlobalKpiSetting(isActive: isActive);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmployeeKpiSetting({
    required int employeeId,
    required bool isActive,
  }) async {
    try {
      await remoteDataSource.updateEmployeeKpiSetting(
        employeeId: employeeId,
        isActive: isActive,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
