import '../../../../../../../../core/network/api_client.dart';
import '../models/employee_kpi_model.dart';
import '../models/kpi_settings_model.dart';

/// Remote data source for Aktivasi Point (KPI Settings)
abstract class AktivasiPointRemoteDataSource {
  /// Get KPI settings from API
  Future<KpiSettingsModel> getKpiSettings();

  /// Get KPI setting for a specific employee by ID
  Future<EmployeeKpiModel> getEmployeeKpiById(int employeeId);

  /// Update global KPI activation setting
  Future<void> updateGlobalKpiSetting({required bool isActive});

  /// Update specific employee KPI activation setting
  Future<void> updateEmployeeKpiSetting({
    required int employeeId,
    required bool isActive,
  });
}

/// Implementation of AktivasiPointRemoteDataSource
class AktivasiPointRemoteDataSourceImpl implements AktivasiPointRemoteDataSource {
  final ApiClient apiClient;

  AktivasiPointRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<KpiSettingsModel> getKpiSettings() async {
    try {
      // Use dioGolang for Golang microservice endpoint
      final response = await apiClient.dioGolang.get(
        '/employee/employee-kpi-setting',
      );

      // Handle V1 API response format {code, message, data}
      if (response.statusCode == 200) {
        final data = response.data['data'];
        return KpiSettingsModel.fromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to get KPI settings',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<EmployeeKpiModel> getEmployeeKpiById(int employeeId) async {
    try {
      final response = await apiClient.dioGolang.get(
        '/employee/employee-kpi-setting/get-by-employee/$employeeId',
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return EmployeeKpiModel.fromJson(data);
      } else {
        throw Exception(
          response.data['message'] ?? 'Failed to get employee KPI setting',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateGlobalKpiSetting({required bool isActive}) async {
    try {
      // Use dioGolang for Golang microservice endpoint
      final response = await apiClient.dioGolang.put(
        '/employee/employee-kpi-setting/update-global',
        data: {
          'is_active': isActive,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
          response.data['message'] ?? 'Failed to update global KPI setting',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateEmployeeKpiSetting({
    required int employeeId,
    required bool isActive,
  }) async {
    try {
      // Use dioGolang for Golang microservice endpoint
      final response = await apiClient.dioGolang.put(
        '/employee/employee-kpi-setting/update-by-employee/$employeeId',
        data: {
          'is_active': isActive,
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
          response.data['message'] ?? 'Failed to update employee KPI setting',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
