import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/home_repository.dart';

class GetEmployeeProfile implements UseCase<Employee, NoParams> {
  final HomeRepository repository;

  GetEmployeeProfile(this.repository);

  @override
  Future<Either<Failure, Employee>> call(NoParams params) async {
    return await repository.getEmployeeProfile();
  }
}
