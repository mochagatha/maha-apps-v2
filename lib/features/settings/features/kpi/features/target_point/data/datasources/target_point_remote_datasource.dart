import '../../../../../../../../core/error/exceptions.dart';
import '../../../../../../../../core/network/api_client.dart';
import '../models/target_point_indicator_model.dart';

/// Remote data source interface for Target Point KPI
abstract class TargetPointRemoteDataSource {
  /// Fetch target point indicators from API
  /// GET: employee/kpi-indicator?type_indicator=Target Poin
  /// Uses BASE_URL_GOLANG
  Future<List<TargetPointIndicatorModel>> getTargetPointIndicators();

  /// Update target point indicator value
  /// PUT: employee/kpi-indicator/update/{id}
  /// Body: {"value": newValue}
  /// Uses BASE_URL_GOLANG
  Future<void> updateTargetPointIndicator({
    required int id,
    required int value,
  });
}

/// Implementation of TargetPointRemoteDataSource
class TargetPointRemoteDataSourceImpl implements TargetPointRemoteDataSource {
  final ApiClient client;

  TargetPointRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TargetPointIndicatorModel>> getTargetPointIndicators() async {
    try {
      // Use dioGolang for GOLANG endpoints
      final response = await client.dioGolang.get(
        '/employee/kpi-indicator',
        queryParameters: {
          'type_indicator': 'Target Poin',
        },
      );

      if (response.statusCode == 200) {
        // Extract data from V1 API response format
        final data = response.data['data']['target_point'];

        if (data is List) {
          return data.map((json) => TargetPointIndicatorModel.fromJson(json)).toList();
        } else {
          throw ServerException('Invalid response format: data is not a list');
        }
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get target point indicators',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to get target point indicators: ${e.toString()}');
    }
  }

  @override
  Future<void> updateTargetPointIndicator({
    required int id,
    required int value,
  }) async {
    try {
      // Use dioGolang for GOLANG endpoints
      final response = await client.dioGolang.put(
        '/employee/kpi-indicator/update/$id',
        data: {
          'value': value,
        },
      );

      if (response.statusCode != 200) {
        throw ServerException(
          response.data['message'] ?? 'Failed to update target point indicator',
        );
      }
      // Success - no return value needed
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to update target point indicator: ${e.toString()}');
    }
  }
}
