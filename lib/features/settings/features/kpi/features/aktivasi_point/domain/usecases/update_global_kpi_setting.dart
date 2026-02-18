import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../repositories/aktivasi_point_repository.dart';

/// Use case for updating global KPI activation setting
/// Updates the is_active flag for all employees globally
class UpdateGlobalKpiSetting implements UseCase<void, UpdateGlobalKpiParams> {
  final AktivasiPointRepository repository;

  UpdateGlobalKpiSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateGlobalKpiParams params) async {
    return await repository.updateGlobalKpiSetting(isActive: params.isActive);
  }
}

/// Parameters for updating global KPI setting
class UpdateGlobalKpiParams extends Equatable {
  final bool isActive;

  const UpdateGlobalKpiParams({required this.isActive});

  @override
  List<Object?> get props => [isActive];
}
