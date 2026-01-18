// Auth Repository Interface
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/auth_response.dart';
import '../entities/register_response.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  /// Login with email and password
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  /// Logout current user
  Future<Either<Failure, void>> logout();

  /// Get current authenticated user from local storage
  Future<Either<Failure, User>> getCurrentUser();

  /// Check if user is logged in
  Future<Either<Failure, bool>> isLoggedIn();

  /// Save login status (remember me)
  Future<Either<Failure, void>> saveLoginStatus(bool rememberMe);

  /// Clear all auth data
  Future<Either<Failure, void>> clearAuthData();

  /// Register new user
  Future<Either<Failure, RegisterResponse>> register({
    required String fullname,
    required String email,
    required String password,
  });
}
