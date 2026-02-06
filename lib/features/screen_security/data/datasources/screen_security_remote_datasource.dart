import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/screen_security_model.dart';

abstract class ScreenSecurityRemoteDataSource {
  Future<ScreenSecurityModel> getScreenSecuritySettings({
    required String type,
    required int employeeWorkerId,
  });
}

class ScreenSecurityRemoteDataSourceImpl implements ScreenSecurityRemoteDataSource {
  final ApiClient apiClient;

  ScreenSecurityRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ScreenSecurityModel> getScreenSecuritySettings({
    required String type,
    required int employeeWorkerId,
  }) async {
    try {
      final response = await apiClient.dioGolang.get(
        '/record-screen-app/get-by-employee-worker-id',
        queryParameters: {'type': type, 'employee_worker_id': employeeWorkerId},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        // Extract data field from V1 API response format
        if (data['data'] != null) {
          return ScreenSecurityModel.fromJson(data['data']);
        } else {
          throw ServerException('No data found in response');
        }
      } else {
        throw ServerException('Failed to fetch screen security settings');
      }
    } catch (e) {
      throw ServerException('Error fetching screen security settings: $e');
    }
  }
}
