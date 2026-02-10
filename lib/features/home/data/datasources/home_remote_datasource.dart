import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/employee_model.dart';
import '../models/kpi_model.dart';
import '../models/menu_item_model.dart';
import '../models/notification_count_model.dart';

abstract class HomeRemoteDataSource {
  /// Get employee profile from API
  Future<EmployeeModel> getEmployeeProfile();

  /// Get employee menus from API
  Future<List<MenuItemModel>> getEmployeeMenus();

  /// Get admin menus from API with user_type parameter
  Future<List<MenuItemModel>> getAdminMenus();

  /// Get hierarchical employee menus from API
  Future<List<MenuItemModel>> getHierarchicalMenus();

  /// Get notification count from API
  Future<NotificationCountModel> getNotificationCount();

  /// Get KPI summary from API
  Future<KpiModel> getKpiSummary({required int month, required int year});
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeModel> getEmployeeProfile() async {
    try {
      // Get employee_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');

      if (employeeId == null) {
        throw ServerException('Employee ID not found. Please login again.');
      }

      // Use dioGolang for employee profile (V1 compatible)
      // V1 uses: BASE_URL_GOLANG + /employee/{id}
      final response = await client.dioGolang.get('/employee/$employeeId');

      if (response.statusCode == 200) {
        return EmployeeModel.fromJson(response.data['data']);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get employee profile');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get employee profile: ${e.toString()}');
    }
  }

  @override
  Future<List<MenuItemModel>> getEmployeeMenus() async {
    try {
      // Get employee_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');

      if (employeeId == null) {
        throw ServerException('Employee ID not found. Please login again.');
      }

      // Use dioGolang for menu endpoint (V1 compatible)
      // Token is automatically added by interceptor
      final response = await client.dioGolang.get(
        AppConstants.endpointEmployeeMenus,
        queryParameters: {'employee_id': employeeId},
      );

      if (response.statusCode == 200) {
        print('DEBUG: Menu Response Data: ${response.data}'); // Debugging line
        final List<dynamic> menusJson = response.data['data'] ?? [];
        print('DEBUG: Parsed Menus Count: ${menusJson.length}'); // Debugging line
        return menusJson.map((json) => MenuItemModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get employee menus');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get employee menus: ${e.toString()}');
    }
  }

  @override
  Future<List<MenuItemModel>> getAdminMenus() async {
    try {
      // Get employee_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');

      if (employeeId == null) {
        throw ServerException('Employee ID not found. Please login again.');
      }

      // Use dioGolang for menu endpoint with user_type parameter for admin
      final response = await client.dioGolang.get(
        AppConstants.endpointEmployeeMenus,
        queryParameters: {'employee_id': employeeId, 'user_type': 'admin'},
      );

      if (response.statusCode == 200) {
        print('DEBUG: Admin Menu Response Data: ${response.data}'); // Debugging line
        final List<dynamic> menusJson = response.data['data'] ?? [];
        print('DEBUG: Parsed Admin Menus Count: ${menusJson.length}'); // Debugging line
        return menusJson.map((json) => MenuItemModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get admin menus');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get admin menus: ${e.toString()}');
    }
  }

  @override
  Future<List<MenuItemModel>> getHierarchicalMenus() async {
    try {
      // Get employee_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');

      if (employeeId == null) {
        throw ServerException('Employee ID not found. Please login again.');
      }

      // Use dioGolang for hierarchical menu endpoint
      // This endpoint returns menu with children structure
      final response = await client.dioGolang.get(
        AppConstants.endpointEmployeeMenus,
        queryParameters: {'employee_id': employeeId},
      );

      if (response.statusCode == 200) {
        print('DEBUG: Hierarchical Menu Response Data: ${response.data}');
        final List<dynamic> menusJson = response.data['data'] ?? [];
        print('DEBUG: Parsed Hierarchical Menus Count: ${menusJson.length}');
        return menusJson.map((json) => MenuItemModel.fromJson(json)).toList();
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get hierarchical menus');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get hierarchical menus: ${e.toString()}');
    }
  }

  @override
  Future<NotificationCountModel> getNotificationCount() async {
    try {
      // Get employee_id and job_title_id from SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final employeeId = prefs.getInt('employee_id');
      final jobTitleId = prefs.getInt('job_title_id');

      if (employeeId == null) {
        throw ServerException('Employee ID not found. Please login again.');
      }

      // Use dioGolang for notification count (V1 compatible)
      // V1 uses: BASE_URL_GOLANG + /employee/employee-notification/count-by-job-title
      // Method: POST with body { employee_id, job_title_id }
      final response = await client.dioGolang.post(
        '/employee/employee-notification/count-by-job-title',
        data: {'employee_id': employeeId, 'job_title_id': jobTitleId ?? 0},
      );

      if (response.statusCode == 200) {
        return NotificationCountModel.fromJson(response.data['data']);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get notification count');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get notification count: ${e.toString()}');
    }
  }

  @override
  Future<KpiModel> getKpiSummary({required int month, required int year}) async {
    try {
      final response = await client.dioGolang.post(
        '/employee/employee-monitoring-kpi/get-by-month',
        data: {'month': month, 'year': year},
      );

      if (response.statusCode == 200) {
        return KpiModel.fromJson(response.data);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to get KPI summary');
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get KPI summary: ${e.toString()}');
    }
  }
}
