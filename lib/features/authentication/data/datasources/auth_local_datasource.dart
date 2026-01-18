// Auth Local Data Source - SharedPreferences operations
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/constants.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  /// Get cached user
  Future<UserModel> getCachedUser();

  /// Cache user data
  Future<void> cacheUser(UserModel user);

  /// Save login status (remember me)
  Future<void> saveLoginStatus(bool rememberMe);

  /// Get login status
  Future<bool> getLoginStatus();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Clear all auth data
  Future<void> clearAuthData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<UserModel> getCachedUser() async {
    try {
      final jsonString = sharedPreferences.getString(AppConstants.keyUserId);
      if (jsonString != null) {
        return UserModel.fromJson(json.decode(jsonString));
      } else {
        throw CacheException('No cached user found');
      }
    } catch (e) {
      throw CacheException('Failed to get cached user: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) async {
    try {
      final jsonString = json.encode(user.toJson());
      await sharedPreferences.setString(AppConstants.keyUserId, jsonString);

      // Also save important fields separately for easy access
      if (user.employeeId != null) {
        await sharedPreferences.setInt('employee_id', user.employeeId!);
      }
      if (user.jobTitleId != null) {
        await sharedPreferences.setInt('job_title_id', user.jobTitleId!);
      }
      if (user.token != null) {
        await sharedPreferences.setString(AppConstants.keyToken, user.token!);
      }
      if (user.refreshToken != null) {
        await sharedPreferences.setString(
          AppConstants.keyRefreshToken,
          user.refreshToken!,
        );
      }
      if (user.branchCode != null) {
        await sharedPreferences.setString(
          AppConstants.keyBranchCode,
          user.branchCode!,
        );
      }
    } catch (e) {
      throw CacheException('Failed to cache user: ${e.toString()}');
    }
  }

  @override
  Future<void> saveLoginStatus(bool rememberMe) async {
    try {
      await sharedPreferences.setBool(AppConstants.keyIsLoggedIn, rememberMe);
      await sharedPreferences.setBool(AppConstants.keyRememberMe, rememberMe);
    } catch (e) {
      throw CacheException('Failed to save login status: ${e.toString()}');
    }
  }

  @override
  Future<bool> getLoginStatus() async {
    try {
      return sharedPreferences.getBool(AppConstants.keyIsLoggedIn) ?? false;
    } catch (e) {
      throw CacheException('Failed to get login status: ${e.toString()}');
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final isLoggedIn =
          sharedPreferences.getBool(AppConstants.keyIsLoggedIn) ?? false;
      final token = sharedPreferences.getString(AppConstants.keyToken);
      return isLoggedIn && token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearAuthData() async {
    try {
      await sharedPreferences.remove(AppConstants.keyUserId);
      await sharedPreferences.remove(AppConstants.keyToken);
      await sharedPreferences.remove(AppConstants.keyRefreshToken);
      await sharedPreferences.remove(AppConstants.keyBranchCode);
      await sharedPreferences.remove(AppConstants.keyIsLoggedIn);
      // Keep remember me preference
      // await sharedPreferences.remove(AppConstants.keyRememberMe);
    } catch (e) {
      throw CacheException('Failed to clear auth data: ${e.toString()}');
    }
  }
}
