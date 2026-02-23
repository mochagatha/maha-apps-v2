import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../repositories/aktivasi_point_repository.dart';

/// Use case for updating specific employee KPI activation setting
/// Updates the is_active flag for a specific employee by their ID
class UpdateEmployeeKpiSetting implements UseCase<void, UpdateEmployeeKpiParams> {
  final AktivasiPointRepository repository;

  UpdateEmployeeKpiSetting(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateEmployeeKpiParams params) async {
    return await repository.updateEmployeeKpiSetting(
      employeeId: params.employeeId,
      isActive: params.isActive,
    );
  }
}

/// Parameters for updating employee KPI setting
class UpdateEmployeeKpiParams extends Equatable {
  final int employeeId;
  final bool isActive;

  const UpdateEmployeeKpiParams({
    required this.employeeId,
    required this.isActive,
  });

  @override
  List<Object?> get props => [employeeId, isActive];
}
