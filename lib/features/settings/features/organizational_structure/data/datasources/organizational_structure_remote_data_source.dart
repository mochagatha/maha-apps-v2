import '../../../../../../core/config/api_endpoints.dart';

import '../../../../../../core/network/api_client.dart';
import '../models/department_model.dart';
import '../models/employee_model.dart';
import '../models/employment_level_model.dart';
import '../models/job_title_model.dart';
import '../models/organizational_structure_model.dart';
import '../models/user_role_model.dart';

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
  Future<void> updateSuperiorEmployeeDepartment({
    required int id,
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
  });
  Future<void> deleteSuperiorEmployeeDepartment(int id);
  Future<OrganizationalStructureModel> getStructureDetail(int id);
  Future<List<EmploymentLevelModel>> getUserRoles(String typeBranch);
  Future<List<UserRoleModel>> getUserRolesByType(String typeRole, {String? typeBranch});
  Future<List<UserRoleModel>> getUserRolesList({
    required String typeRole,
    required String typeBranch,
  });
  Future<void> addUserRole({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  });
  Future<void> updateUserRole({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  });
  Future<void> deleteUserRole(int id);
  Future<List<JobTitleModel>> getJobTitles({required String typeRole, required String typeBranch});
  Future<void> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  });
  Future<void> updateJobTitle({required int id, required String name});
  Future<void> deleteJobTitle(int id);
  Future<List<DepartmentModel>> getDepartments();
  Future<List<DepartmentModel>> getDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  });
  Future<void> addDepartment({
    required String name,
    required String typeRole,
    required String typeBranch,
  });
  Future<void> updateDepartment({required int id, required String name});
  Future<void> deleteDepartment(int id);
  Future<List<EmploymentLevelModel>> getEmploymentLevels();
  Future<List<EmploymentLevelModel>> getEmploymentLevelsByType({required String typeRole});
  Future<void> addEmploymentLevel({required String name, required String typeRole});
  Future<void> updateEmploymentLevel({required int id, required String name});
  Future<void> deleteEmploymentLevel(int id);
  Future<List<EmployeeModel>> getEmployees({int? jobTitleId});
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
  Future<void> updateSuperiorEmployeeDepartment({
    required int id,
    required int superiorEmployeeStructureId,
    required int departmentId,
    required List<int> employeeIds,
  }) async {
    try {
      await client.dioGolang.put(
        '${ApiEndpoints.superiorEmployeeDepartmentUpdate}/$id',
        data: {
          'superior_employee_structure_id': superiorEmployeeStructureId,
          'department_id': departmentId,
          'employee_ids': employeeIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteSuperiorEmployeeDepartment(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.superiorEmployeeDepartmentDelete}/$id');
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
  Future<List<UserRoleModel>> getUserRolesByType(String typeRole, {String? typeBranch}) async {
    try {
      final Map<String, dynamic> queryParameters = {'type_role': typeRole};
      if (typeBranch != null) {
        queryParameters['type_branch'] = typeBranch;
      }
      final response = await client.dioGolang.get(
        ApiEndpoints.userRole,
        queryParameters: queryParameters,
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => UserRoleModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserRoleModel>> getUserRolesList({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.userRoleList,
        queryParameters: {'type_role': typeRole, 'type_branch': typeBranch},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => UserRoleModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUserRole({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'type_role': typeRole,
        'type_branch': typeBranch,
      };

      if (supervisorRoleId != null) {
        data['supervisor_role_id'] = supervisorRoleId;
      }

      await client.dioGolang.post(ApiEndpoints.userRole, data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateUserRole({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'type_role': typeRole,
        'type_branch': typeBranch,
      };

      if (supervisorRoleId != null) {
        data['supervisor_role_id'] = supervisorRoleId;
      }

      await client.dioGolang.put('${ApiEndpoints.userRoleUpdate}/$id', data: data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserRole(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.userRoleDelete}/$id');
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
        data: {'name': name, 'type_role': typeRole, 'type_branch': typeBranch},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateJobTitle({required int id, required String name}) async {
    try {
      await client.dioGolang.put('${ApiEndpoints.jobTitle}/$id', data: {'name': name});
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

  @override
  Future<List<DepartmentModel>> getDepartmentsByType({
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.getAllDepartment,
        queryParameters: {'type_role': typeRole, 'type_branch': typeBranch},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => DepartmentModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addDepartment({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.getAllDepartment,
        data: {'department_name': name, 'type_role': typeRole, 'type_branch': typeBranch},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateDepartment({required int id, required String name}) async {
    try {
      await client.dioGolang.put(
        '${ApiEndpoints.getAllDepartment}/$id',
        data: {'department_name': name},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteDepartment(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.getAllDepartment}/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EmploymentLevelModel>> getEmploymentLevels() async {
    try {
      final response = await client.dioGolang.get(ApiEndpoints.userRole);

      final List<dynamic> data = response.data['data'];
      return data.map((json) => EmploymentLevelModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EmploymentLevelModel>> getEmploymentLevelsByType({required String typeRole}) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.userRole,
        queryParameters: {'type_role': typeRole},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => EmploymentLevelModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addEmploymentLevel({required String name, required String typeRole}) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.userRole,
        data: {'name': name, 'type_role': typeRole},
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEmploymentLevel({required int id, required String name}) async {
    try {
      await client.dioGolang.put('${ApiEndpoints.userRole}/$id', data: {'name': name});
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEmploymentLevel(int id) async {
    try {
      await client.dioGolang.delete('${ApiEndpoints.userRole}/$id');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EmployeeModel>> getEmployees({int? jobTitleId}) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.getAllEmployees,
        queryParameters: jobTitleId != null ? {'job_title': jobTitleId} : null,
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => EmployeeModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
