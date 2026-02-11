import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/employee_model.dart';

abstract class HomeLocalDataSource {
  /// Cache employee profile
  Future<void> cacheEmployeeProfile(EmployeeModel employee);

  /// Get cached employee profile
  Future<EmployeeModel?> getCachedEmployeeProfile();

  /// Clear all cached home data
  Future<void> clearCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String keyEmployeeProfile = 'CACHED_EMPLOYEE_PROFILE';

  HomeLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheEmployeeProfile(EmployeeModel employee) async {
    try {
      final jsonString = json.encode(employee.toJson());
      await sharedPreferences.setString(keyEmployeeProfile, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache employee profile: ${e.toString()}');
    }
  }

  @override
  Future<EmployeeModel?> getCachedEmployeeProfile() async {
    try {
      final jsonString = sharedPreferences.getString(keyEmployeeProfile);
      if (jsonString != null) {
        final jsonMap = json.decode(jsonString);
        return EmployeeModel.fromJson(jsonMap);
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached employee profile: ${e.toString()}');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(keyEmployeeProfile);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
