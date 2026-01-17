// Auth Provider - State management for authentication
import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/get_current_user.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final Login login;
  final Logout logout;
  final GetCurrentUser getCurrentUser;
  final CheckAuthStatus checkAuthStatus;

  AuthProvider({
    required this.login,
    required this.logout,
    required this.getCurrentUser,
    required this.checkAuthStatus,
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
  Future<void> loginUser(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await login(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (failure) {
        _status = AuthStatus.error;
        _errorMessage = failure.message;
        _user = null;
      },
      (authResponse) {
        _status = AuthStatus.authenticated;
        _user = authResponse.data;
        _errorMessage = null;
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
}
