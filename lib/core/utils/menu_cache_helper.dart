import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../features/home/domain/entities/menu_item.dart';
import '../../features/home/presentation/providers/home_provider.dart';

/// Helper class to access cached hierarchical menus from anywhere in the app
/// 
/// This helper provides static methods to easily access menu data that has been
/// cached by the HomeProvider. It eliminates the need to repeatedly call APIs
/// for menu data across different pages.
/// 
/// Usage:
/// ```dart
/// // Get all menus
/// final menus = MenuCacheHelper.getAllMenus(context);
/// 
/// // Find specific menu by code
/// final menu = MenuCacheHelper.findMenuByCode(context, 'ABSENSI');
/// 
/// // Get children of a menu
/// final children = MenuCacheHelper.getChildrenByCode(context, 'PERSETUJUAN');
/// ```
class MenuCacheHelper {
  /// Get all hierarchical menus from provider
  /// Returns the complete menu tree with parent-child relationships
  static List<MenuItem> getAllMenus(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return provider.hierarchicalMenus;
  }

  /// Find menu by code
  /// Searches recursively through the menu tree to find a menu with the given code
  /// Returns null if no menu with the code is found
  static MenuItem? findMenuByCode(BuildContext context, String code) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return provider.findMenuByCode(code);
  }

  /// Get children menus by parent code
  /// Returns the list of child menus for the menu with the given code
  /// Returns empty list if menu not found or has no children
  static List<MenuItem> getChildrenByCode(BuildContext context, String code) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return provider.getChildrenByCode(code);
  }

  /// Refresh menu cache (force reload from API)
  /// Use this when you need to update the menu data, for example after
  /// menu permissions have changed
  static Future<void> refreshMenuCache(BuildContext context) async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    await provider.refreshHierarchicalMenus();
  }

  /// Check if menus are loaded
  /// Returns true if hierarchical menus have been loaded
  static bool areMenusLoaded(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return provider.hierarchicalMenus.isNotEmpty;
  }

  /// Get menu count
  /// Returns the total number of top-level menus
  static int getMenuCount(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    return provider.hierarchicalMenus.length;
  }
}
