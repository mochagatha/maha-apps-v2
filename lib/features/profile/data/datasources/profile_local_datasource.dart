import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/employee_model.dart';

/// Profile local data source interface
abstract class ProfileLocalDataSource {
  /// Get cached employee profile
  Future<EmployeeModel?> getCachedProfile();

  /// Cache employee profile
  Future<void> cacheProfile(EmployeeModel employee);

  /// Clear cached profile
  Future<void> clearCache();
}

/// Implementation of ProfileLocalDataSource
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _cachedProfileKey = 'CACHED_EMPLOYEE_PROFILE';

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<EmployeeModel?> getCachedProfile() async {
    try {
      final jsonString = sharedPreferences.getString(_cachedProfileKey);
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString) as Map<String, dynamic>;
        return EmployeeModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached profile: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheProfile(EmployeeModel employee) async {
    try {
      final jsonString = json.encode(employee.toJson());
      await sharedPreferences.setString(_cachedProfileKey, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache profile: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(_cachedProfileKey);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
