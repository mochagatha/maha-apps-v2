// Auth Remote Data Source - API calls
import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/auth_response_model.dart';
import '../models/register_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<AuthResponseModel> login({required String email, required String password});

  /// Logout (if API endpoint exists)
  Future<void> logout();

  /// Register new user
  Future<RegisterResponseModel> register({
    required String fullname,
    required String email,
    required String password,
  });

  /// Verify company code
  Future<bool> verifyCompanyCode(String code);

  /// Get user profile
  Future<UserModel> getProfile(String token);

  /// Upload admin photo with location data
  Future<void> uploadAdminPhoto({
    required int adminId,
    required String imagePath,
    required String locationName,
    required String location,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> login({required String email, required String password}) async {
    try {
      final response = await client.dioGolang.post(
        AppConstants.endpointLogin,
        data: {'email': email, 'password': password},
      );

      // Match V1 logic: Check if status is success
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw ServerException('Email Atau Password Salah');
      }
    } on DioException catch (e) {
      // Handler specific for V1 error format
      final errorData = e.response?.data;
      String message = 'Email Atau Password Salah';

      if (errorData is List && errorData.isNotEmpty && errorData.first is Map<String, dynamic>) {
        message = errorData.first['message'] ?? 'Terjadi kesalahan Hubungi HRD';
      } else if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        message = errorData['message'];
      }

      throw ServerException(message);
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to login: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await client.post(AppConstants.endpointLogout);
    } catch (e) {
      throw ServerException('Failed to logout: ${e.toString()}');
    }
  }

  @override
  Future<RegisterResponseModel> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      // Use dioGolang for register endpoint (V1 compatible)
      final response = await client.dioGolang.post(
        AppConstants.endpointRegister,
        data: {'fullname': fullname, 'email': email, 'password': password},
      );

      // Match V1 logic for success check (can vary, so checking status code primarily)
      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      // Handler specific for error format
      final errorData = e.response?.data;
      String message = 'Registration failed';

      if (errorData is List && errorData.isNotEmpty && errorData.first is Map<String, dynamic>) {
        message = errorData.first['message'] ?? 'Terjadi kesalahan. Silakan coba lagi.';
      } else if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        message = errorData['message'];
      }

      throw ServerException(message);
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to register: ${e.toString()}');
    }
  }

  @override
  Future<bool> verifyCompanyCode(String code) async {
    try {
      final response = await client.dioGolang.post(
        '/letter/code-company/compare',
        data: {'code': code},
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException('Invalid code');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw CompanyCodeNotVerifiedException();
      }

      final errorData = e.response?.data;
      String message = 'Verification failed';

      if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        message = errorData['message'];
      }

      throw ServerException(message);
    } catch (e) {
      if (e is CompanyCodeNotVerifiedException || e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to verify code: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> getProfile(String token) async {
    try {
      final response = await client.dioGolang.post(
        AppConstants.endpointGetByToken, // Assuming this constant exists or will be added
        options: Options(headers: {'Authorization': token}),
      );

      if (response.statusCode == 200 && response.data['status'] == 'success') {
        final employeeData = response.data['data'];

        // Map specific fields to UserModel
        final employeeId = employeeData['id'] as int?;
        final jobTitleId = employeeData['job_title']?['id'] as int?;
        final branchCode = employeeData['branch']?['branch_code'] as String?;
        final status = employeeData['status'] as int?;

        return UserModel(
          employeeId: employeeId,
          jobTitleId: jobTitleId,
          branchCode: branchCode,
          status: status,
          token: token,
        );
      } else {
        throw ServerException('Failed to fetch profile');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ServerException('Unauthorized');
      }
      throw ServerException('Failed to fetch profile: ${e.message}');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Failed to fetch profile: ${e.toString()}');
    }
  }

  @override
  Future<void> uploadAdminPhoto({
    required int adminId,
    required String imagePath,
    required String locationName,
    required String location,
  }) async {
    try {
      // Create multipart file from image path
      final multipartFile = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );

      // Create form data
      final formData = FormData.fromMap({
        'admin_id': adminId,
        'location_name': locationName,
        'location': location,
        'photos': multipartFile,
      });

      // Send to Golang API
      final response = await client.dioGolang.post(
        '/admin/upload-photo',
        data: formData,
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ServerException('Failed to upload photo');
      }
    } on DioException catch (e) {
      final errorData = e.response?.data;
      String message = 'Failed to upload photo';

      if (errorData is Map<String, dynamic> && errorData.containsKey('message')) {
        message = errorData['message'];
      }

      throw ServerException(message);
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to upload photo: ${e.toString()}');
    }
  }
}
