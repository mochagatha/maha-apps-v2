import '../../../../core/config/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/menu_access_model.dart';

/// Remote data source for menu access operations
abstract class AccessMenuRemoteDataSource {
  /// Get menus currently assigned to an employee
  Future<List<MenuAccessModel>> getEmployeeMenus(int employeeId);

  /// Get all available menu items in the system
  Future<List<MenuAccessModel>> getAllMenus();

  /// Assign menus to an employee
  Future<void> createEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  });

  /// Remove menus from an employee
  Future<void> deleteEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  });
}

class AccessMenuRemoteDataSourceImpl implements AccessMenuRemoteDataSource {
  final ApiClient client;

  AccessMenuRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MenuAccessModel>> getEmployeeMenus(int employeeId) async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.employeeMenuApplication,
        queryParameters: {'employee_id': employeeId},
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => MenuAccessModel.fromJson(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MenuAccessModel>> getAllMenus() async {
    try {
      final response = await client.dioGolang.get(
        ApiEndpoints.menuApplication,
      );

      final List<dynamic> data = response.data['data'];
      return data.map((json) => MenuAccessModel.fromJsonAllMenus(json)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> createEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    try {
      await client.dioGolang.post(
        ApiEndpoints.createEmployeeMenuApplication,
        data: {
          'employee_id': employeeId,
          'menu_application_ids': menuIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    try {
      await client.dioGolang.delete(
        ApiEndpoints.deleteEmployeeMenuApplication,
        data: {
          'employee_id': employeeId,
          'menu_application_ids': menuIds,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
