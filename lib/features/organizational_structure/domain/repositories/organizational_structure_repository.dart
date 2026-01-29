import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/department_entity.dart';
import '../entities/employment_level_entity.dart';
import '../entities/job_title_entity.dart';
import '../entities/organizational_structure_entity.dart';

abstract class OrganizationalStructureRepository {
  /// Get company structure by type (utama, project, cabang)
  Future<Either<Failure, List<OrganizationalStructureEntity>>> getCompanyStructure(
    String typeStructure,
  );

  /// Create company structure role
  Future<Either<Failure, void>> createCompanyStructureRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  });

  /// Delete company structure role
  Future<Either<Failure, void>> deleteCompanyStructureRole(int id);

  /// Add superior employee to structure
  Future<Either<Failure, void>> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  });

  /// Edit superior employee
  Future<Either<Failure, void>> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  });

  /// Delete superior employee
  Future<Either<Failure, void>> deleteSuperiorEmployee(int superiorEmployeeId);

  /// Add superior employee department
  Future<Either<Failure, void>> addSuperiorEmployeeDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  });

  /// Edit superior employee department (employees)
  Future<Either<Failure, void>> editSuperiorEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  });

  /// Edit superior worker department (workers)
  Future<Either<Failure, void>> editSuperiorWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  });

  /// Get structure detail by ID
  Future<Either<Failure, OrganizationalStructureEntity>> getStructureDetail(int id);

  /// Get user roles by type branch
  Future<Either<Failure, List<EmploymentLevelEntity>>> getUserRoles(String typeBranch);

  /// Get job titles by type role and type branch
  Future<Either<Failure, List<JobTitleEntity>>> getJobTitles({
    required String typeRole,
    required String typeBranch,
  });

  /// Get all departments
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments();
}
