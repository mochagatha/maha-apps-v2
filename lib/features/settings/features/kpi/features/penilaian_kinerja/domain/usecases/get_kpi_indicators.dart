import 'package:dartz/dartz.dart';
import '../../../../../../../../../core/error/failures.dart';
import '../../../../../../../../../core/usecases/usecase.dart';
import '../entities/kpi_indicators_data.dart';
import '../repositories/penilaian_kinerja_repository.dart';

class GetKpiIndicators implements UseCase<KpiIndicatorsData, NoParams> {
  final PenilaianKinerjaRepository repository;

  GetKpiIndicators(this.repository);

  @override
  Future<Either<Failure, KpiIndicatorsData>> call(NoParams params) async {
    return await repository.getKpiIndicators();
  }
}
