import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/department_entity.dart';
import '../entities/employee_entity.dart';
import '../entities/employment_level_entity.dart';
import '../entities/job_title_entity.dart';
import '../entities/user_role_entity.dart';
import '../repositories/organizational_structure_repository.dart';

class GetOrganizationalData {
  final OrganizationalStructureRepository repository;

  GetOrganizationalData(this.repository);

  Future<Either<Failure, List<EmploymentLevelEntity>>> getUserRoles(String typeBranch) async {
    return await repository.getUserRoles(typeBranch);
  }

  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesByType(String typeRole) async {
    return await repository.getUserRolesByType(typeRole);
  }

  Future<Either<Failure, List<JobTitleEntity>>> getJobTitles({
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.getJobTitles(typeRole: typeRole, typeBranch: typeBranch);
  }

  Future<Either<Failure, List<DepartmentEntity>>> getDepartments() async {
    return await repository.getDepartments();
  }

  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.getDepartmentsByType(typeRole: typeRole, typeBranch: typeBranch);
  }

  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevels() async {
    return await repository.getEmploymentLevels();
  }

  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevelsByType({
    required String typeRole,
  }) async {
    return await repository.getEmploymentLevelsByType(typeRole: typeRole);
  }

  Future<Either<Failure, List<EmployeeEntity>>> getEmployees() async {
    return await repository.getEmployees();
  }

  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesList({
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.getUserRolesList(typeRole: typeRole, typeBranch: typeBranch);
  }
}
