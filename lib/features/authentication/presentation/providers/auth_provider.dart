// Auth Provider - State management for authentication
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/save_login_status.dart';
import '../../domain/usecases/verify_company_code.dart';
import '../../domain/usecases/get_profile.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final Login login;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final CheckAuthStatus checkAuthStatus;
  final Register register;
  final SaveLoginStatus saveLoginStatus;
  final VerifyCompanyCode verifyCompanyCode;
  final GetProfile getProfile;

  AuthProvider({
    required this.login,
    required this.logout,
    required this.getCurrentUser,
    required this.checkAuthStatus,
    required this.register,
    required this.saveLoginStatus,
    required this.verifyCompanyCode,
    required this.getProfile,
  });

  AuthStatus _status = AuthStatus.initial;
  User? _user;
  String? _errorMessage;
  bool _isAdmin = false;

  // Getters
  AuthStatus get status => _status;
  User? get user => _user;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _status == AuthStatus.authenticated;
  bool get isAdmin => _isAdmin;
  bool get isLoading => _status == AuthStatus.loading;

  /// Login user
  Future<void> loginUser(String email, String password, {bool rememberMe = false}) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await login(LoginParams(email: email, password: password));

    await result.fold(
      (failure) async {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        _user = null;
      },
      (authResponse) async {
        // Login successful, save token first
        final prefs = await SharedPreferences.getInstance();
        if (authResponse.data.token != null) {
          await prefs.setString('auth_token', authResponse.data.token!);
          await prefs.setString(
            'refresh_token',
            authResponse.data.refreshToken ?? authResponse.data.token!,
          );
        }

        // Fetch user profile using UseCase
        final profileResult = await getProfile(const NoParams());

        profileResult.fold(
          (failure) {
            // Even if profile fetch fails, we're still logged in
            // But we should try to use the data we got from login at least
            _status = AuthStatus.authenticated;
            _user = authResponse.data;
            _errorMessage = null; // or show a warning?
          },
          (user) {
            _status = AuthStatus.authenticated;
            _user = user;
            _errorMessage = null;
          },
        );

        // Save login status
        if (rememberMe) {
          await saveLoginStatus(SaveLoginStatusParams(rememberMe: true));
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
        _isAdmin = false;
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
          await userResult.fold(
            (failure) async {
              _status = AuthStatus.unauthenticated;
              _user = null;
              _isAdmin = false;
            },
            (user) async {
              // User is logged in locally, now try to fetch fresh profile
              // to ensure we have the latest status
              if (user.token != null) {
                final profileResult = await getProfile(const NoParams());
                profileResult.fold(
                  (failure) {
                    // If fetch fails, we fall back to cached user
                    // (or should we?)
                    _status = AuthStatus.authenticated;
                    _user = user;
                  },
                  (freshUser) {
                    _status = AuthStatus.authenticated;
                    _user = freshUser;
                  },
                );
              } else {
                _status = AuthStatus.authenticated;
                _user = user;
              }
            },
          );
        } else {
          _status = AuthStatus.unauthenticated;
          _user = null;
        }
      },
    );

    // Check admin status
    final adminResult = await _getIsAdmin();
    _isAdmin = adminResult;

    notifyListeners();
  }

  /// Set admin status
  Future<void> setAdminStatus(bool isAdmin) async {
    _isAdmin = isAdmin;
    await _saveIsAdmin(isAdmin);
    notifyListeners();
  }

  Future<bool> _getIsAdmin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_admin') ?? false;
  }

  Future<void> _saveIsAdmin(bool isAdmin) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_admin', isAdmin);
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Reset to unauthenticated state
  void resetToUnauthenticated() {
    if (_status == AuthStatus.loading) {
      _status = AuthStatus.unauthenticated;
      _errorMessage = null;
      notifyListeners();
    }
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
      RegisterParams(fullname: fullname, email: email, password: password),
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

  /// Verify company code
  Future<bool> verifyCode(String code) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await verifyCompanyCode(VerifyCompanyCodeParams(code: code));

    return result.fold(
      (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (success) {
        _status = AuthStatus.unauthenticated;
        _errorMessage = null;
        notifyListeners();
        return true;
      },
    );
  }
}
