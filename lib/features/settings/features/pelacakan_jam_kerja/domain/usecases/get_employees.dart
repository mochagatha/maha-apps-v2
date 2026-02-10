import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/tracking_employee.dart';
import '../repositories/pelacakan_repository.dart';

class GetEmployees implements UseCase<List<TrackingEmployee>, EmployeesParams> {
  final PelacakanRepository repository;

  GetEmployees(this.repository);

  @override
  Future<Either<Failure, List<TrackingEmployee>>> call(EmployeesParams params) async {
    return await repository.getEmployees(params.employeeType);
  }
}

class EmployeesParams extends Equatable {
  final String employeeType;

  const EmployeesParams({required this.employeeType});

  @override
  List<Object?> get props => [employeeType];
}
