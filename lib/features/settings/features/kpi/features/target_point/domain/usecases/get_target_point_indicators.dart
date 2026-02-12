import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../entities/target_point_indicator.dart';
import '../repositories/target_point_repository.dart';

/// Use case for getting target point KPI indicators
class GetTargetPointIndicators implements UseCase<List<TargetPointIndicator>, NoParams> {
  final TargetPointRepository repository;

  GetTargetPointIndicators(this.repository);

  @override
  Future<Either<Failure, List<TargetPointIndicator>>> call(NoParams params) async {
    return await repository.getTargetPointIndicators();
  }
}
