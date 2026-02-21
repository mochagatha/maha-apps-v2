import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../entities/employee_kpi_entity.dart';
import '../repositories/aktivasi_point_repository.dart';

/// Use case for getting a specific employee's KPI setting by their ID
class GetEmployeeKpiById implements UseCase<EmployeeKpi, GetEmployeeKpiByIdParams> {
  final AktivasiPointRepository repository;

  GetEmployeeKpiById(this.repository);

  @override
  Future<Either<Failure, EmployeeKpi>> call(GetEmployeeKpiByIdParams params) async {
    return await repository.getEmployeeKpiById(params.employeeId);
  }
}

/// Parameters for getting employee KPI by ID
class GetEmployeeKpiByIdParams extends Equatable {
  final int employeeId;

  const GetEmployeeKpiByIdParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
