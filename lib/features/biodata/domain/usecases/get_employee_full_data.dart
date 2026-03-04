import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee_full_data.dart';
import '../repositories/biodata_repository.dart';

class GetEmployeeFullData implements UseCase<EmployeeFullData, GetEmployeeFullDataParams> {
  final BiodataRepository repository;

  GetEmployeeFullData(this.repository);

  @override
  Future<Either<Failure, EmployeeFullData>> call(GetEmployeeFullDataParams params) async {
    return await repository.getEmployeeFullData(params.employeeId);
  }
}

class GetEmployeeFullDataParams extends Equatable {
  final int employeeId;

  const GetEmployeeFullDataParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
