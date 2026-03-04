import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employment_level_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/job_title_entity.dart';
import '../../domain/entities/organizational_structure_entity.dart';
import '../../domain/entities/user_role_entity.dart';
import '../../domain/repositories/organizational_structure_repository.dart';
import '../datasources/organizational_structure_remote_data_source.dart';

class OrganizationalStructureRepositoryImpl implements OrganizationalStructureRepository {
  final OrganizationalStructureRemoteDataSource remoteDataSource;

  OrganizationalStructureRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<OrganizationalStructureEntity>>> getCompanyStructure(
    String typeStructure,
  ) async {
    try {
      final result = await remoteDataSource.getCompanyStructure(typeStructure);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data?['message'] ?? 'Terjadi kesalahan server'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> createCompanyStructureRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  }) async {
    try {
      await remoteDataSource.createCompanyStructureRole(
        companyStructureId: companyStructureId,
        userRoleIds: userRoleIds,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan role'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCompanyStructureRole(int id) async {
    try {
      await remoteDataSource.deleteCompanyStructureRole(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus role'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    try {
      await remoteDataSource.addSuperiorEmployee(
        companyStructureId: companyStructureId,
        roleStructureId: roleStructureId,
        employeeId: employeeId,
        jobTitleId: jobTitleId,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan superior employee'),
      );
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    try {
      await remoteDataSource.editSuperiorEmployee(
        superiorEmployeeId: superiorEmployeeId,
        employeeId: employeeId,
        jobTitleId: jobTitleId,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah superior employee'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSuperiorEmployee(int superiorEmployeeId) async {
    try {
      await remoteDataSource.deleteSuperiorEmployee(superiorEmployeeId);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus superior employee'),
      );
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addSuperiorEmployeeDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  }) async {
    try {
      await remoteDataSource.addSuperiorEmployeeDepartment(
        superiorEmployeeStructureId: superiorEmployeeStructureId,
        departmentId: departmentId,
        employeeIds: employeeIds,
        workerIds: workerIds,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> editSuperiorEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  }) async {
    try {
      await remoteDataSource.editSuperiorEmployeeDepartment(
        id: id,
        employeeIds: employeeIds,
        deleteEmployeeIds: deleteEmployeeIds,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah employee departemen'),
      );
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> editSuperiorWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  }) async {
    try {
      await remoteDataSource.editSuperiorWorkerDepartment(
        id: id,
        workerIds: workerIds,
        deleteWorkerIds: deleteWorkerIds,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah worker departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> updateSuperiorEmployeeDepartment({
    required int id,
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
  }) async {
    try {
      await remoteDataSource.updateSuperiorEmployeeDepartment(
        id: id,
        superiorEmployeeStructureId: superiorEmployeeStructureId,
        departmentId: departmentId,
        employeeIds: employeeIds,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSuperiorEmployeeDepartment(int id) async {
    try {
      await remoteDataSource.deleteSuperiorEmployeeDepartment(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, OrganizationalStructureEntity>> getStructureDetail(int id) async {
    try {
      final result = await remoteDataSource.getStructureDetail(id);
      return Right(result.toEntity());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil detail struktur'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<EmploymentLevelEntity>>> getUserRoles(String typeBranch) async {
    try {
      final result = await remoteDataSource.getUserRoles(typeBranch);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil user roles'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesByType(
    String typeRole, {
    String? typeBranch,
  }) async {
    try {
      final result = await remoteDataSource.getUserRolesByType(typeRole, typeBranch: typeBranch);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil user roles'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<UserRoleEntity>>> getUserRolesList({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final result = await remoteDataSource.getUserRolesList(
        typeRole: typeRole,
        typeBranch: typeBranch,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil user roles'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addUserRole({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await remoteDataSource.addUserRole(
        name: name,
        supervisorRoleId: supervisorRoleId,
        typeRole: typeRole,
        typeBranch: typeBranch,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan tingkatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserRole({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await remoteDataSource.updateUserRole(
        id: id,
        name: name,
        supervisorRoleId: supervisorRoleId,
        typeRole: typeRole,
        typeBranch: typeBranch,
      );
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengupdate tingkatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserRole(int id) async {
    try {
      await remoteDataSource.deleteUserRole(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus tingkatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<JobTitleEntity>>> getJobTitles({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final result = await remoteDataSource.getJobTitles(
        typeRole: typeRole,
        typeBranch: typeBranch,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil job titles'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await remoteDataSource.addJobTitle(name: name, typeRole: typeRole, typeBranch: typeBranch);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan jabatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> updateJobTitle({required int id, required String name}) async {
    try {
      await remoteDataSource.updateJobTitle(id: id, name: name);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah jabatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteJobTitle(int id) async {
    try {
      await remoteDataSource.deleteJobTitle(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus jabatan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartments() async {
    try {
      final result = await remoteDataSource.getDepartments();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil departments'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<DepartmentEntity>>> getDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final result = await remoteDataSource.getDepartmentsByType(
        typeRole: typeRole,
        typeBranch: typeBranch,
      );
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengambil departments'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addDepartment({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await remoteDataSource.addDepartment(name: name, typeRole: typeRole, typeBranch: typeBranch);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menambahkan departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> updateDepartment({required int id, required String name}) async {
    try {
      await remoteDataSource.updateDepartment(id: id, name: name);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal mengubah departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDepartment(int id) async {
    try {
      await remoteDataSource.deleteDepartment(id);
      return const Right(null);
    } on DioException catch (e) {
      return Left(ServerFailure(e.response?.data['message'] ?? 'Gagal menghapus departemen'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevels() async {
    try {
      final result = await remoteDataSource.getEmploymentLevels();
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal mengambil employment levels'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<EmploymentLevelEntity>>> getEmploymentLevelsByType({
    required String typeRole,
  }) async {
    try {
      final result = await remoteDataSource.getEmploymentLevelsByType(typeRole: typeRole);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal mengambil employment levels'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> addEmploymentLevel({
    required String name,
    required String typeRole,
  }) async {
    try {
      await remoteDataSource.addEmploymentLevel(name: name, typeRole: typeRole);
      return const Right(null);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal menambahkan employment level'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> updateEmploymentLevel({
    required int id,
    required String name,
  }) async {
    try {
      await remoteDataSource.updateEmploymentLevel(id: id, name: name);
      return const Right(null);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal mengupdate employment level'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEmploymentLevel(int id) async {
    try {
      await remoteDataSource.deleteEmploymentLevel(id);
      return const Right(null);
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal menghapus employment level'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }

  @override
  Future<Either<Failure, List<EmployeeEntity>>> getEmployees({int? jobTitleId}) async {
    try {
      final result = await remoteDataSource.getEmployees(jobTitleId: jobTitleId);
      return Right(result.map((model) => model.toEntity()).toList());
    } on DioException catch (e) {
      final errorMessage = e.response?.data is Map
          ? e.response?.data['message']
          : e.response?.statusMessage;
      return Left(ServerFailure(errorMessage ?? 'Gagal mengambil data karyawan'));
    } catch (e) {
      return Left(ServerFailure('Terjadi kesalahan tidak terduga'));
    }
  }
}
