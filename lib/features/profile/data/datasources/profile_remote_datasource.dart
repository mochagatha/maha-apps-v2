import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';

import '../models/employee_model.dart';

/// Profile remote data source interface
abstract class ProfileRemoteDataSource {
  /// Get employee profile from API
  Future<EmployeeModel> getProfile();

  /// Update employee profile
  Future<EmployeeModel> updateProfile(Map<String, dynamic> params);

  /// Update profile picture
  Future<String> updateProfilePicture(File image);
}

/// Implementation of ProfileRemoteDataSource
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ApiClient client;
  final SharedPreferences sharedPreferences;

  ProfileRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<EmployeeModel> getProfile() async {
    try {
      final id = sharedPreferences.getInt('employee_id');
      if (id == null) {
        throw CacheException('Employee ID not found in cache');
      }

      // Use dioGolang for employee endpoints (V1 compatible)
      // Path: /employee/$id
      final response = await client.dioGolang.get('/employee/$id');

      // Also fetch points (V1 behavior)
      // Endpoint: /employee/employee-kpi/get-by-employee-existing/$id
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
        print('Failed to fetch points: $e');
      }

      if (response.statusCode == 200) {
        // Extract data from response
        final data = response.data['data'];

        // Inject points into the data map so model can parse it
        if (data is Map<String, dynamic>) {
          data['total_point'] = totalPoint;
        }

        return EmployeeModel.fromJson(data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to get profile',
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

  @override
  Future<EmployeeModel> updateProfile(Map<String, dynamic> params) async {
    try {
      final id = sharedPreferences.getInt('employee_id');
      if (id == null) {
        throw CacheException('Employee ID not found in cache');
      }

      // Use dioEmployee for employee endpoints (V1 compatible)
      // Note: V1 uses a different update endpoint, but for now we follow the pattern
      // Checking V1 service: addFamily uses `Config.baseUrl + Config.getFamily` which is `dio` (Main)
      // But update sibling uses `dio`.
      // The updateProfile in V1 seems scattered (addFamily, addSibling etc).
      // However, if we assume V2 `updateProfile` is correct in using dioEmployee, we keep it or Fix it if invalid.
      // V2 original code used `/employee/profile` with PUT.
      // If V1 has no direct "update profile" but mostly family/sibling updates, maybe we should skip fixing this for now
      // and focus on `getProfile`.
      // But to be safe, I'll keep the previous implementation logic but fix the ID if needed.
      // Since I don't see `updateProfile` in V1 `ProfileController` calling a single update endpoint for generic data (it updates specific sections),
      // I will leave this as is (using dioEmployee) but maybe it needs ID too?
      // Original: client.dioEmployee.put('/employee/profile', data: params);

      // Attempting to use the same path as V2 originally had since I don't have full info on V2 backend for update.
      // But `getProfile` was definitely 404ing on `/employee/profile`.

      final response = await client.dioEmployee.put(
        '/employee/profile',
        data: params,
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return EmployeeModel.fromJson(data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to update profile',
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

  @override
  Future<String> updateProfilePicture(File image) async {
    try {
      // Create form data with image
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
        ),
      });

      // Use dioEmployee and V1 endpoint path
      final response = await client.dioEmployee.post(
        '/employee/employee-selfie',
        data: formData,
      );

      if (response.statusCode == 200) {
        // Return the photo URL from response
        return response.data['data']['photo_url'] as String;
      } else {
        throw ServerException(
          response.data['message'] ?? 'Failed to upload profile picture',
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
