import 'package:flutter/foundation.dart';
import '../../domain/entities/menu_access_entity.dart';
import '../../domain/usecases/get_all_menus.dart';
import '../../domain/usecases/get_employee_menus.dart';
import '../../domain/usecases/manage_menu_access.dart';

/// Provider for managing access menu state
class AccessMenuProvider with ChangeNotifier {
  final GetEmployeeMenus getEmployeeMenus;
  final GetAllMenus getAllMenus;
  final ManageMenuAccess manageMenuAccess;

  AccessMenuProvider({
    required this.getEmployeeMenus,
    required this.getAllMenus,
    required this.manageMenuAccess,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<MenuAccessEntity> _allMenus = [];
  List<MenuAccessEntity> get allMenus => _allMenus;

  List<int> _initialMenuIds = [];
  List<int> get initialMenuIds => _initialMenuIds;

  List<int> _selectedMenuIds = [];
  List<int> get selectedMenuIds => _selectedMenuIds;

  List<int> _unselectedMenuIds = [];
  List<int> get unselectedMenuIds => _unselectedMenuIds;

  /// Get all menus in a flat structure (including nested children)
  List<MenuAccessEntity> get _deepMenus {
    final deepMenus = [..._allMenus];
    for (var menu in _allMenus) {
      final deepChildren = _deepExtractChildren(menu);
      deepMenus.addAll(deepChildren);
    }
    return deepMenus;
  }

  /// Get currently selected menu IDs (initial + selected - unselected)
  List<int> get currentSelectedIds {
    final selected = [..._initialMenuIds, ..._selectedMenuIds];
    selected.removeWhere((id) => _unselectedMenuIds.contains(id));
    return selected;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Load employee menus and all available menus
  Future<void> loadMenus(int employeeId) async {
    _setLoading(true);
    _setError(null);

    // Load employee menus
    final employeeMenusResult = await getEmployeeMenus(employeeId);
    employeeMenusResult.fold(
      (failure) => _setError(failure.message),
      (menus) {
        _initialMenuIds = _extractIds(menus);
      },
    );

    // Load all menus
    final allMenusResult = await getAllMenus();
    allMenusResult.fold(
      (failure) => _setError(failure.message),
      (menus) {
        _allMenus = menus;
        notifyListeners();
      },
    );

    _selectedMenuIds = [];
    _unselectedMenuIds = [];
    _setLoading(false);
  }

  /// Select a menu and all its children recursively
  void selectMenu(int id) {
    final menu = _deepMenus.firstWhere((menu) => menu.id == id);
    final childrenIds = menu.children?.map((menu) => menu.id).toList() ?? [];

    // Recursively select children
    for (var childId in childrenIds) {
      selectMenu(childId);
    }

    // Remove from unselected list
    _unselectedMenuIds.removeWhere((menuId) => menuId == id);

    // Add to selected list if not initially selected
    if (!_initialMenuIds.contains(id)) {
      if (!_selectedMenuIds.contains(id)) {
        _selectedMenuIds.add(id);
      }
    }

    notifyListeners();
  }

  /// Unselect a menu and all its children recursively
  void unselectMenu(int id) {
    final menu = _deepMenus.firstWhere((menu) => menu.id == id);
    final childrenIds = menu.children?.map((menu) => menu.id).toList() ?? [];

    // Recursively unselect children
    for (var childId in childrenIds) {
      unselectMenu(childId);
    }

    // Remove from selected list
    _selectedMenuIds.removeWhere((menuId) => menuId == id);

    // Add to unselected list if initially selected
    if (_initialMenuIds.contains(id)) {
      if (!_unselectedMenuIds.contains(id)) {
        _unselectedMenuIds.add(id);
      }
    }

    notifyListeners();
  }

  /// Submit changes to the server
  Future<bool> submitChanges(int employeeId) async {
    _setLoading(true);
    _setError(null);

    // Sort IDs for consistency
    _selectedMenuIds.sort();
    _unselectedMenuIds.sort();

    // Create selected menus
    if (_selectedMenuIds.isNotEmpty) {
      final createResult = await manageMenuAccess.createMenus(
        employeeId: employeeId,
        menuIds: _selectedMenuIds,
      );

      final hasError = createResult.fold(
        (failure) {
          _setError(failure.message);
          return true;
        },
        (_) => false,
      );

      if (hasError) {
        _setLoading(false);
        return false;
      }
    }

    // Delete unselected menus
    if (_unselectedMenuIds.isNotEmpty) {
      final deleteResult = await manageMenuAccess.deleteMenus(
        employeeId: employeeId,
        menuIds: _unselectedMenuIds,
      );

      final hasError = deleteResult.fold(
        (failure) {
          _setError(failure.message);
          return true;
        },
        (_) => false,
      );

      if (hasError) {
        _setLoading(false);
        return false;
      }
    }

    _setLoading(false);
    return true;
  }

  /// Extract all menu IDs from a list of menus (including children)
  List<int> _extractIds(List<MenuAccessEntity> menus) {
    List<int> ids = [];
    for (var menu in menus) {
      ids.add(menu.id);
      final childrenIds = _extractIds(menu.children ?? []);
      ids.addAll(childrenIds);
    }
    return ids;
  }

  /// Deep extract all children from a menu
  List<MenuAccessEntity> _deepExtractChildren(MenuAccessEntity menu) {
    final List<MenuAccessEntity> children = [...menu.children ?? []];
    final deepChildren = [...children];
    for (var child in children) {
      deepChildren.addAll(_deepExtractChildren(child));
    }
    return deepChildren;
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
