import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/config/api_endpoints.dart';
import '../models/forgot_password_status_model.dart';
import '../models/forgot_password_verification_data_model.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordStatusModel> sendOtp(String email);
  Future<ForgotPasswordVerificationDataModel> verifyOtp(String email, String code);
  Future<void> resetPassword(
    int id,
    String oldPassword,
    String password,
    String confirmationPassword,
  );
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final ApiClient client;

  ForgotPasswordRemoteDataSourceImpl({required this.client});

  @override
  Future<ForgotPasswordStatusModel> sendOtp(String email) async {
    final url = EnvConfig.apiBaseUrl + ApiEndpoints.sendOtp;
    try {
      final response = await client.dio.post(url, data: {"email": email});
      if (response.statusCode == 200) {
        return ForgotPasswordStatusModel.fromJson(response.data);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to send OTP');
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? e.message ?? 'Server Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ForgotPasswordVerificationDataModel> verifyOtp(String email, String code) async {
    // Note: Assuming endpoint is defined in ApiEndpoints or using the string directly if not.
    // Based on previous reads: static const String verifyOtp = '/employee/verify-otp-forgot-password';
    final url = EnvConfig.apiBaseUrl + ApiEndpoints.verifyOtp;
    try {
      final response = await client.dio.post(url, data: {
        "email": email,
        "code": code,
      });
      if (response.statusCode == 200) {
        return ForgotPasswordVerificationDataModel.fromJson(response.data);
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to verify OTP');
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? e.message ?? 'Server Error');
    } catch (e) {
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
    try {
      final response = await client.dio.post(url, data: {
        "employee_id": id,
        "old_password": oldPassword,
        "password": password,
        "password_confirmation": confirmationPassword,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerException(response.data['message'] ?? 'Failed to reset password');
      }
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? e.message ?? 'Server Error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
