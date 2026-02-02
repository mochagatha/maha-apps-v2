import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/kpi.dart';
import '../repositories/home_repository.dart';

class GetKpiSummary implements UseCase<Kpi, KpiParams> {
  final HomeRepository repository;

  GetKpiSummary(this.repository);

  @override
  Future<Either<Failure, Kpi>> call(KpiParams params) async {
    return await repository.getKpiSummary(
      month: params.month,
      year: params.year,
    );
  }
}

class KpiParams {
  final int month;
  final int year;

  KpiParams({required this.month, required this.year});
}
