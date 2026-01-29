import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageSuperiorEmployee {
  final OrganizationalStructureRepository repository;

  ManageSuperiorEmployee(this.repository);

  Future<Either<Failure, void>> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    return await repository.addSuperiorEmployee(
      companyStructureId: companyStructureId,
      roleStructureId: roleStructureId,
      employeeId: employeeId,
      jobTitleId: jobTitleId,
    );
  }

  Future<Either<Failure, void>> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    return await repository.editSuperiorEmployee(
      superiorEmployeeId: superiorEmployeeId,
      employeeId: employeeId,
      jobTitleId: jobTitleId,
    );
  }

  Future<Either<Failure, void>> deleteSuperiorEmployee(int superiorEmployeeId) async {
    return await repository.deleteSuperiorEmployee(superiorEmployeeId);
  }

  Future<Either<Failure, void>> addDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  }) async {
    return await repository.addSuperiorEmployeeDepartment(
      superiorEmployeeStructureId: superiorEmployeeStructureId,
      departmentId: departmentId,
      employeeIds: employeeIds,
      workerIds: workerIds,
    );
  }

  Future<Either<Failure, void>> editEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  }) async {
    return await repository.editSuperiorEmployeeDepartment(
      id: id,
      employeeIds: employeeIds,
      deleteEmployeeIds: deleteEmployeeIds,
    );
  }

  Future<Either<Failure, void>> editWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  }) async {
    return await repository.editSuperiorWorkerDepartment(
      id: id,
      workerIds: workerIds,
      deleteWorkerIds: deleteWorkerIds,
    );
  }
}
