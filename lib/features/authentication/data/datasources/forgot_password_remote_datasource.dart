import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/config/api_endpoints.dart';
import '../models/forgot_password_status_model.dart';
import '../models/forgot_password_verification_data_model.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordStatusModel> sendOtp(String email);
  Future<ForgotPasswordVerificationDataModel> verifyOtp(
    String email,
    String code,
  );
  Future<void> resetPassword(
    int id,
    String oldPassword,
    String password,
    String confirmationPassword,
  );
}

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final ApiClient client;

  ForgotPasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<ForgotPasswordStatusModel> sendOtp(String email) async {
    final url = EnvConfig.apiBaseUrl + ApiEndpoints.sendOtp;
    try {
      final response = await client.dio.post(url, data: {"email": email});
      // v1 returns: {status, code, message}
      // Check if response has valid structure
      if (response.data != null &&
          response.data is Map &&
          response.data.containsKey('code')) {
        final code = response.data['code'];
        if (code == 200) {
          return ForgotPasswordStatusModel.fromJson(response.data);
        } else {
          // Server returned error code (e.g., 400 for email not found)
          throw ServerException(
            response.data['message'] ?? 'Failed to send OTP',
          );
        }
      } else {
        throw ServerException('Invalid response format');
      }
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        throw ServerException(
          e.response!.data['message'] ?? e.message ?? 'Server Error',
        );
      }
      throw ServerException(e.message ?? 'Server Error');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ForgotPasswordVerificationDataModel> verifyOtp(
    String email,
    String code,
  ) async {
    final url = EnvConfig.apiBaseUrl + ApiEndpoints.verifyOtp;
    try {
      final response = await client.dio.post(
        url,
        data: {"email": email, "code": code},
      );
      // v1 returns: {status, code, message, data: {employee_id, old_password}}
      if (response.data != null &&
          response.data is Map &&
          response.data.containsKey('code')) {
        final responseCode = response.data['code'];
        if (responseCode == 200) {
          return ForgotPasswordVerificationDataModel.fromJson(response.data);
        } else {
          throw ServerException(
            response.data['message'] ?? 'Failed to verify OTP',
          );
        }
      } else {
        throw ServerException('Invalid response format');
      }
    } on DioException catch (e) {
      if (e.response?.data != null && e.response!.data is Map) {
        throw ServerException(
          e.response!.data['message'] ?? e.message ?? 'Server Error',
        );
      }
      throw ServerException(e.message ?? 'Server Error');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> resetPassword(
    int id,
    String oldPassword,
    String password,
    String confirmationPassword,
  ) async {
    final url = EnvConfig.apiBaseUrl + ApiEndpoints.resetPassword;

    // Log request data for debugging
    print('🔄 Reset Password Request:');
    print('  URL: $url');
    print('  employee_id: $id');
    print('  old_password: ${oldPassword.isNotEmpty ? "***" : "EMPTY"}');
    print('  password: ${password.isNotEmpty ? "***" : "EMPTY"}');
    print(
      '  password_confirmation: ${confirmationPassword.isNotEmpty ? "***" : "EMPTY"}',
    );

    try {
      final requestData = {
        "employee_id": id,
        "old_password": oldPassword,
        "password": password,
        "password_confirmation": confirmationPassword,
      };

      final response = await client.dio.post(url, data: requestData);

      // Log successful response
      print('✅ Reset Password Response: ${response.data}');

      // v1 returns: {status, code, message}
      if (response.data != null &&
          response.data is Map &&
          response.data.containsKey('code')) {
        final responseCode = response.data['code'];
        if (responseCode == 200) {
          print('✅ Password reset successful');
          return;
        } else {
          final errorMsg =
              response.data['message'] ?? 'Failed to reset password';
          print('❌ Reset Password Failed: $errorMsg (code: $responseCode)');
          throw ServerException(errorMsg);
        }
      } else {
        print('❌ Invalid response format: ${response.data}');
        throw ServerException('Invalid response format');
      }
    } on DioException catch (e) {
      print('❌ DioException during reset password:');
      print('  Status Code: ${e.response?.statusCode}');
      print('  Response Data: ${e.response?.data}');
      print('  Error Message: ${e.message}');

      if (e.response?.data != null && e.response!.data is Map) {
        throw ServerException(
          e.response!.data['message'] ?? e.message ?? 'Server Error',
        );
      }
      throw ServerException(e.message ?? 'Server Error');
    } catch (e) {
      print('❌ Unexpected error during reset password: $e');
      if (e is ServerException) rethrow;
      throw ServerException(e.toString());
    }
  }
}
