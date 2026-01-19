// Auth Provider - State management for authentication
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/user_model.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/save_login_status.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final Login login;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final CheckAuthStatus checkAuthStatus;
  final Register register;
  final SaveLoginStatus saveLoginStatus;

  AuthProvider({
    required this.login,
    required this.logout,
    required this.getCurrentUser,
    required this.checkAuthStatus,
    required this.register,
    required this.saveLoginStatus,
  });

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isLoading => _status == AuthStatus.loading;

  /// Login user
  Future<void> loginUser(String email, String password, {bool rememberMe = false}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await login(
      LoginParams(email: email, password: password),
    );

    await result.fold(
      (failure) async {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        _user = null;
      },
      (authResponse) async {
        // Login successful, now fetch employee profile to get employee_id and job_title_id
        // This matches V1 flow: login -> getDataEmployeeByToken -> save employee data
        try {
          final prefs = await SharedPreferences.getInstance();
          
          // First save the token so we can use it for the next request
          if (authResponse.data.token != null) {
            await prefs.setString('auth_token', authResponse.data.token!);
            await prefs.setString('refresh_token', authResponse.data.refreshToken ?? authResponse.data.token!);
          }
          
          // Now fetch employee data using the token
          // V1 uses: POST BASE_URL_GOLANG/employee/get-by-token
          final dio = Dio();
          dio.options.baseUrl = dotenv.env['BASE_URL_GOLANG'] ?? '';
          dio.options.headers['Authorization'] = authResponse.data.token;
          
          // V1 calls this endpoint after login to get employee data
          final profileResponse = await dio.post('/employee/get-by-token');
          
          if (profileResponse.statusCode == 200 && profileResponse.data['status'] == 'success') {
            final employeeData = profileResponse.data['data'];
            final employeeId = employeeData['id'] as int?;
            final jobTitleId = employeeData['job_title']?['id'] as int?;
            final branchCode = employeeData['branch']?['branch_code'] as String?;
            
            // Update user with employee_id and job_title_id
            final updatedUser = UserModel(
              employeeId: employeeId,
              jobTitleId: jobTitleId,
              branchCode: branchCode ?? authResponse.data.branchCode,
              token: authResponse.data.token,
              refreshToken: authResponse.data.refreshToken,
            );
            
            // Save updated user
            await prefs.setString('user_data', json.encode(updatedUser.toJson()));
            if (employeeId != null) {
              await prefs.setInt('employee_id', employeeId);
            }
            if (jobTitleId != null) {
              await prefs.setInt('job_title_id', jobTitleId);
            }
            
            _user = updatedUser;
          }
          


          // Save login status
          if (rememberMe) {
            await saveLoginStatus(SaveLoginStatusParams(rememberMe: true));
          }
          
          _status = AuthStatus.authenticated;
          _errorMessage = null;
        } catch (e) {
          debugPrint('Error fetching employee data after login: $e');
          // Even if profile fetch fails, we're still logged in
          _status = AuthStatus.authenticated;
          _user = authResponse.data;
          _errorMessage = null;
        }
      },
    );

    notifyListeners();
  }

  /// Logout user
  Future<void> logoutUser() async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await logout(const NoParams());

    result.fold(
      (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
      },
      (_) {
        _status = AuthStatus.unauthenticated;
        _user = null;
        _errorMessage = null;
      },
    );

    notifyListeners();
  }

  /// Check authentication status
  Future<void> checkAuth() async {
    _status = AuthStatus.loading;
    notifyListeners();

    final result = await checkAuthStatus(const NoParams());

    result.fold(
      (failure) {
        _status = AuthStatus.unauthenticated;
        _user = null;
      },
      (isLoggedIn) async {
        if (isLoggedIn) {
          // Get user data
          final userResult = await getCurrentUser(const NoParams());
          userResult.fold(
            (failure) {
              _status = AuthStatus.unauthenticated;
              _user = null;
            },
            (user) {
              _status = AuthStatus.authenticated;
              _user = user;
            },
          );
        } else {
          _status = AuthStatus.unauthenticated;
          _user = null;
        }
      },
    );

    notifyListeners();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Register new user
  Future<void> registerUser({
    required String fullname,
    required String email,
    required String password,
  }) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await register(
      RegisterParams(
        fullname: fullname,
        email: email,
        password: password,
      ),
    );

    result.fold(
      (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
      },
      (registerResponse) {
        _status = AuthStatus.unauthenticated;
        _errorMessage = null;
        // Registration successful, user needs to login
      },
    );

    notifyListeners();
  }
}
