// Auth Remote Data Source - API calls
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/utils/constants.dart';
import '../models/auth_response_model.dart';
import '../models/register_response_model.dart';

abstract class AuthRemoteDataSource {
  /// Login with email and password
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  });

  /// Logout (if API endpoint exists)
  Future<void> logout();

  /// Register new user
  Future<RegisterResponseModel> register({
    required String fullname,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      // Use dioGolang for login endpoint (V1 compatible)
      final response = await client.dioGolang.post(
        AppConstants.endpointLogin,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Login failed',
        );
      }
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
        data: {
          'fullname': fullname,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return RegisterResponseModel.fromJson(response.data);
      } else {
        throw ServerException(
          response.data['message'] ?? 'Registration failed',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw ServerException('Failed to register: ${e.toString()}');
    }
  }
}
