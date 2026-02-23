import 'package:dartz/dartz.dart';
import '../../../../../../../../../core/error/failures.dart';
import '../../../../../../../../../core/usecases/usecase.dart';
import '../repositories/penilaian_kinerja_repository.dart';

export '../repositories/penilaian_kinerja_repository.dart' show KpiIndicatorUpdateItem;

class UpdateManyKpiIndicatorsParams {
  final List<KpiIndicatorUpdateItem> items;
  const UpdateManyKpiIndicatorsParams({required this.items});
}

class UpdateManyKpiIndicators implements UseCase<void, UpdateManyKpiIndicatorsParams> {
  final PenilaianKinerjaRepository repository;

  UpdateManyKpiIndicators(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateManyKpiIndicatorsParams params) async {
    return await repository.updateManyKpiIndicators(params.items);
  }
}
