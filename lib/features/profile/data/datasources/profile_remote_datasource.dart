import 'dart:io';

import 'package:dio/dio.dart';
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

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<EmployeeModel> getProfile() async {
    try {
      final response = await client.get('/employee/profile');

      if (response.statusCode == 200) {
        // Extract data from response
        final data = response.data['data'];
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
      final response = await client.put(
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

      final response = await client.post(
        '/employee/profile/photo',
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
