import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/employee_model.dart';
import '../models/menu_item_model.dart';
import '../models/notification_count_model.dart';

abstract class HomeRemoteDataSource {
  /// Get employee profile from API
  Future<EmployeeModel> getEmployeeProfile();

  /// Get employee menus from API
  Future<List<MenuItemModel>> getEmployeeMenus();

  /// Get notification count from API
  Future<NotificationCountModel> getNotificationCount();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient client;

  HomeRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeModel> getEmployeeProfile() async {
    try {
      final response = await client.get(AppConstants.endpointEmployeeProfile);

      if (response.statusCode == 200) {
        return EmployeeModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get employee profile',
        );
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
      final response = await client.get(AppConstants.endpointEmployeeMenus);

      if (response.statusCode == 200) {
        final List<dynamic> menusJson = response.data['data'] ?? [];
        return menusJson
            .map((json) => MenuItemModel.fromJson(json))
            .toList();
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get employee menus',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get employee menus: ${e.toString()}');
    }
  }

  @override
  Future<NotificationCountModel> getNotificationCount() async {
    try {
      final response = await client.get(AppConstants.endpointNotificationCount);

      if (response.statusCode == 200) {
        return NotificationCountModel.fromJson(response.data['data']);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get notification count',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get notification count: ${e.toString()}');
    }
  }
}
