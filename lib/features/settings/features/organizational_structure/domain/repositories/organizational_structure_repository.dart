import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/department_entity.dart';
import '../entities/employee_entity.dart';
import '../entities/employment_level_entity.dart';
import '../entities/job_title_entity.dart';
import '../entities/organizational_structure_entity.dart';
import '../entities/user_role_entity.dart';

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

  /// Update superior employee department
  Future<Either<Failure, void>> updateSuperiorEmployeeDepartment({
    required int id,
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
  });

  /// Delete superior employee department
  Future<Either<Failure, void>> deleteSuperiorEmployeeDepartment(int id);

  /// Get structure detail by ID
  Future<Either<Failure, OrganizationalStructureEntity>> getStructureDetail(int id);

  /// Get user roles by type branch
  Future<Either<Failure, List<EmploymentLevelEntity>>> getUserRoles(String typeBranch);

  /// Get user roles hierarchy by type role (employee/worker) and optional type branch
  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesByType(
    String typeRole, {
    String? typeBranch,
  });

  /// Get user roles list by type role and type branch
  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesList({
    required String typeRole,
    required String typeBranch,
  });

  /// Add user role
  Future<Either<Failure, void>> addUserRole({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  });

  /// Update user role
  Future<Either<Failure, void>> updateUserRole({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  });

  /// Delete user role
  Future<Either<Failure, void>> deleteUserRole(int id);

  /// Get job titles by type role and type branch
  Future<Either<Failure, List<JobTitleEntity>>> getJobTitles({
    required String typeRole,
    required String typeBranch,
  });

  /// Add job title
  Future<Either<Failure, void>> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  });

  /// Update job title
  Future<Either<Failure, void>> updateJobTitle({required int id, required String name});

  /// Delete job title
  Future<Either<Failure, void>> deleteJobTitle(int id);

  /// Get all departments
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments();

  /// Get departments by type
  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  });

  /// Add department
  Future<Either<Failure, void>> addDepartment({
    required String name,
    required String typeRole,
    required String typeBranch,
  });

  /// Update department
  Future<Either<Failure, void>> updateDepartment({required int id, required String name});

  /// Delete department
  Future<Either<Failure, void>> deleteDepartment(int id);

  /// Get all employment levels
  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevels();

  /// Get employment levels by type
  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevelsByType({
    required String typeRole,
  });

  /// Add employment level
  Future<Either<Failure, void>> addEmploymentLevel({
    required String name,
    required String typeRole,
  });

  /// Update employment level
  Future<Either<Failure, void>> updateEmploymentLevel({required int id, required String name});

  /// Delete employment level
  Future<Either<Failure, void>> deleteEmploymentLevel(int id);

  /// Get all employees, optionally filtered by job title
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({int? jobTitleId});
}
