import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../models/biodata_model.dart';

abstract class BiodataRemoteDataSource {
  Future<BiodataModel> getBiodata();
}

class BiodataRemoteDataSourceImpl implements BiodataRemoteDataSource {
  final ApiClient client;
  final SharedPreferences sharedPreferences;

  BiodataRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<BiodataModel> getBiodata() async {
    try {
      final id = sharedPreferences.getInt('employee_id');
      if (id == null) {
        throw CacheException('Employee ID not found in cache');
      }

      final response = await client.dioGolang.get('/employee/$id');

      double totalPoint = 0.0;
      try {
        final pointsResponse = await client.dio.get(
          '/employee/employee-kpi/get-by-employee-existing/$id',
        );
        if (pointsResponse.statusCode == 200 &&
            pointsResponse.data['data'] != null) {
          final pointsData = pointsResponse.data['data'];
          if (pointsData['total_point'] != null) {
            totalPoint =
                double.tryParse(pointsData['total_point'].toString()) ?? 0.0;
          }
        }
      } catch (e) {
        // Ignore points error, just default to 0.0
      }

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data is Map<String, dynamic>) {
          data['total_point'] = totalPoint;
        }
        return BiodataModel.fromJson(data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get biodata',
        );
      }
    } on DioException catch (e) {
      throw ServerException(
        e.response?.data['message'] ?? 'Network error occurred',
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
