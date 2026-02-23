import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../entities/kpi_settings_entity.dart';
import '../repositories/aktivasi_point_repository.dart';

/// Use case for getting KPI settings
/// Retrieves the complete KPI settings including employee list and global activation status
class GetKpiSettings implements UseCase<KpiSettings, NoParams> {
  final AktivasiPointRepository repository;

  GetKpiSettings(this.repository);

  @override
  Future<Either<Failure, KpiSettings>> call(NoParams params) async {
    return await repository.getKpiSettings();
  }
}
