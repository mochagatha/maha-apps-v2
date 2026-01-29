import '../../../../core/config/api_endpoints.dart';

import '../../../../core/network/api_client.dart';
import '../models/department_model.dart';
import '../models/employment_level_model.dart';
import '../models/job_title_model.dart';
import '../models/organizational_structure_model.dart';

abstract class OrganizationalStructureRemoteDataSource {
  Future<List<OrganizationalStructureModel>> getCompanyStructure(String typeStructure);
  Future<void> createCompanyStructureRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  });
  Future<void> deleteCompanyStructureRole(int id);
  Future<void> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  });
  Future<void> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  });
  Future<void> deleteSuperiorEmployee(int superiorEmployeeId);
  Future<void> addSuperiorEmployeeDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  });
  Future<void> editSuperiorEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  });
  Future<void> editSuperiorWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  });
  Future<OrganizationalStructureModel> getStructureDetail(int id);
  Future<List<EmploymentLevelModel>> getUserRoles(String typeBranch);
  Future<List<JobTitleModel>> getJobTitles({required String typeRole, required String typeBranch});
  Future<void> addJobTitle({required String name, required String typeRole, required String typeBranch});
  Future<void> updateJobTitle({required int id, required String name});
  Future<void> deleteJobTitle(int id);
  Future<List<DepartmentModel>> getDepartments();
}

class OrganizationalStructureRemoteDataSourceImpl
    implements OrganizationalStructureRemoteDataSource {
  final ApiClient client;

  OrganizationalStructureRemoteDataSourceImpl({required this.client});

  @override
  Future<List<OrganizationalStructureModel>> getCompanyStructure(String typeStructure) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.companyStructure,
        queryParameters: {'type_structure': typeStructure},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => OrganizationalStructureModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createCompanyStructureRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.companyStructureRole,
        data: {'company_structure_id': companyStructureId, 'user_role_id': userRoleIds},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCompanyStructureRole(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.companyStructureRoleDelete}/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addSuperiorEmployee({
    required int companyStructureId,
    required int roleStructureId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.superiorEmployee,
        data: {
          'company_structure_id': companyStructureId,
          'role_structure_id': roleStructureId,
          'employee_id': employeeId,
          'job_title_id': jobTitleId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editSuperiorEmployee({
    required int superiorEmployeeId,
    required int employeeId,
    required int jobTitleId,
  }) async {
    try {
      await client.dioGolang.put(
        '${ApiEndpoints.superiorEmployeeUpdate}/$superiorEmployeeId',
        data: {'employee_id': employeeId, 'job_title_id': jobTitleId},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSuperiorEmployee(int superiorEmployeeId) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.superiorEmployeeDelete}/$superiorEmployeeId');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addSuperiorEmployeeDepartment({
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
    required List<int> workerIds,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.superiorEmployeeDepartment,
        data: {
          'superior_employee_structure_id': superiorEmployeeStructureId,
          'department_id': departmentId,
          'employee_ids': employeeIds,
          'worker_ids': workerIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editSuperiorEmployeeDepartment({
    required int id,
    required List<int> employeeIds,
    required List<int> deleteEmployeeIds,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.superiorEmployeeDepartmentEmployee,
        data: {
          'department_structure_id': id,
          'employee_ids': employeeIds,
          'employee_delete_ids': deleteEmployeeIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> editSuperiorWorkerDepartment({
    required int id,
    required List<int> workerIds,
    required List<int> deleteWorkerIds,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.superiorEmployeeDepartmentWorker,
        data: {
          'department_structure_id': id,
          'worker_ids': workerIds,
          'worker_delete_ids': deleteWorkerIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<OrganizationalStructureModel> getStructureDetail(int id) async {
    try {
      final response = await client.dioGolang.get('${ApiEndpoints.companyStructureDetail}/$id');

      return OrganizationalStructureModel.fromJson(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EmploymentLevelModel>> getUserRoles(String typeBranch) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.userRole,
        queryParameters: {'type_branch': typeBranch},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => EmploymentLevelModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<JobTitleModel>> getJobTitles({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.jobTitle,
        queryParameters: {'type_role': typeRole, 'type_branch': typeBranch},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => JobTitleModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.jobTitle,
        data: {
          'name': name,
          'type_role': typeRole,
          'type_branch': typeBranch,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateJobTitle({
    required int id,
    required String name,
  }) async {
    try {
      await client.dioGolang.put(
        '${ApiEndpoints.jobTitle}/$id',
        data: {'name': name},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteJobTitle(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.jobTitle}/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DepartmentModel>> getDepartments() async {
    try {
      final response = await client.dioGolang.get(ApiEndpoints.getAllDepartment);

      final List<dynamic> data = response.data['data'];
      return data.map((json) => DepartmentModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}

