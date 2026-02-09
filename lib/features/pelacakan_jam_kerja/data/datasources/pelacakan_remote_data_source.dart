import '../../../../core/network/api_client.dart';
import '../models/tracking_employee_model.dart';
import '../models/tracking_settings_model.dart';

abstract class PelacakanRemoteDataSource {
  Future<TrackingSettingsModel> getTrackingSettings(String employeeType);
  Future<List<TrackingEmployeeModel>> getEmployees(String employeeType);
  Future<void> saveTrackingSettings({
    required String employeeType,
    required bool isGlobalEnabled,
    required List<int> enabledEmployeeIds,
  });
}

class PelacakanRemoteDataSourceImpl implements PelacakanRemoteDataSource {
  final ApiClient apiClient;

  PelacakanRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<TrackingSettingsModel> getTrackingSettings(String employeeType) async {
    final response = await apiClient.get(
      '/employee/time-tracking-settings',
      queryParameters: {'employee_type': employeeType},
    );

    // Handle V1 API response format {code, message, data}
    final data = response.data['data'] ?? response.data;
    return TrackingSettingsModel.fromJson(data);
  }

  @override
  Future<List<TrackingEmployeeModel>> getEmployees(String employeeType) async {
    final response = await apiClient.get(
      '/employee/time-tracking-employees',
      queryParameters: {'employee_type': employeeType},
    );

    // Handle V1 API response format {code, message, data}
    final data = response.data['data'] ?? response.data;

    if (data is List) {
      return data.map((json) => TrackingEmployeeModel.fromJson(json)).toList();
    }

    return [];
  }

  @override
  Future<void> saveTrackingSettings({
    required String employeeType,
    required bool isGlobalEnabled,
    required List<int> enabledEmployeeIds,
  }) async {
    await apiClient.post(
      '/employee/time-tracking-settings',
      data: {
        'employee_type': employeeType,
        'is_global_enabled': isGlobalEnabled,
        'enabled_employee_ids': enabledEmployeeIds,
      },
    );
  }
}
