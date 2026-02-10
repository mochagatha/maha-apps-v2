import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../models/employee_model.dart';
import '../models/menu_item_model.dart';

abstract class HomeLocalDataSource {
  /// Cache employee profile
  Future<void> cacheEmployeeProfile(EmployeeModel employee);

  /// Get cached employee profile
  Future<EmployeeModel?> getCachedEmployeeProfile();

  /// Cache employee menus
  Future<void> cacheMenus(List<MenuItemModel> menus);

  /// Get cached menus
  Future<List<MenuItemModel>?> getCachedMenus();

  /// Cache hierarchical employee menus
  Future<void> cacheHierarchicalMenus(List<MenuItemModel> menus);

  /// Get cached hierarchical menus
  Future<List<MenuItemModel>?> getCachedHierarchicalMenus();

  /// Check if hierarchical menus cache is valid (within 24 hours)
  Future<bool> isHierarchicalMenusCacheValid();

  /// Clear all cached home data
  Future<void> clearCache();
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String keyEmployeeProfile = 'CACHED_EMPLOYEE_PROFILE';
  static const String keyEmployeeMenus = 'CACHED_EMPLOYEE_MENUS';
  static const String keyHierarchicalMenus = 'CACHED_HIERARCHICAL_MENUS';
  static const String keyHierarchicalMenusTimestamp = 'CACHED_HIERARCHICAL_MENUS_TIMESTAMP';
  
  // Cache validity duration (24 hours)
  static const Duration cacheValidityDuration = Duration(hours: 24);

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
  Future<void> cacheMenus(List<MenuItemModel> menus) async {
    try {
      final jsonList = menus.map((menu) => menu.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(keyEmployeeMenus, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache menus: ${e.toString()}');
    }
  }

  @override
  Future<List<MenuItemModel>?> getCachedMenus() async {
    try {
      final jsonString = sharedPreferences.getString(keyEmployeeMenus);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => MenuItemModel.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached menus: ${e.toString()}');
    }
  }

  @override
  Future<void> cacheHierarchicalMenus(List<MenuItemModel> menus) async {
    try {
      final jsonList = menus.map((menu) => menu.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(keyHierarchicalMenus, jsonString);
      
      // Save timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      await sharedPreferences.setInt(keyHierarchicalMenusTimestamp, timestamp);
    } catch (e) {
      throw CacheException('Failed to cache hierarchical menus: ${e.toString()}');
    }
  }

  @override
  Future<List<MenuItemModel>?> getCachedHierarchicalMenus() async {
    try {
      final jsonString = sharedPreferences.getString(keyHierarchicalMenus);
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => MenuItemModel.fromJson(json)).toList();
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached hierarchical menus: ${e.toString()}');
    }
  }

  @override
  Future<bool> isHierarchicalMenusCacheValid() async {
    try {
      final timestamp = sharedPreferences.getInt(keyHierarchicalMenusTimestamp);
      if (timestamp == null) return false;
      
      final cachedTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      final now = DateTime.now();
      final difference = now.difference(cachedTime);
      
      return difference < cacheValidityDuration;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await sharedPreferences.remove(keyEmployeeProfile);
      await sharedPreferences.remove(keyEmployeeMenus);
      await sharedPreferences.remove(keyHierarchicalMenus);
      await sharedPreferences.remove(keyHierarchicalMenusTimestamp);
    } catch (e) {
      throw CacheException('Failed to clear cache: ${e.toString()}');
    }
  }
}
