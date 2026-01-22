import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/config/env_config.dart';
import '../../../../core/config/api_endpoints.dart';
import '../models/forgot_password_status_model.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordStatusModel> sendOtp(String email);
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
}
