import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/employee.dart';
import '../repositories/profile_repository.dart';

/// Use case for getting employee profile
/// Retrieves the complete employee profile from the repository
class GetEmployeeProfile implements UseCase<Employee, NoParams> {
  final ProfileRepository repository;

  GetEmployeeProfile(this.repository);

  @override
  Future<Either<Failure, Employee>> call(NoParams params) async {
    return await repository.getProfile();
  }
}
