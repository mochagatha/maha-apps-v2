import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/kpi.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/notification_count.dart';
import '../../domain/usecases/get_employee_menus.dart';
import '../../domain/usecases/get_employee_profile.dart';
import '../../domain/usecases/get_hierarchical_menus.dart';
import '../../domain/usecases/get_kpi_summary.dart';
import '../../domain/usecases/get_notification_count.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  final GetEmployeeProfile getEmployeeProfile;
  final GetEmployeeMenus getEmployeeMenus;
  final GetNotificationCount getNotificationCount;
  final GetKpiSummary getKpiSummary;
  final GetHierarchicalMenus getHierarchicalMenus;

  HomeProvider({
    required this.getEmployeeProfile,
    required this.getEmployeeMenus,
    required this.getNotificationCount,
    required this.getKpiSummary,
    required this.getHierarchicalMenus,
  });

  HomeStatus _status = HomeStatus.initial;
  Employee? _employee;
  List<MenuItem> _hierarchicalMenus = [];
  NotificationCount? _notificationCount;
  Kpi? _kpi;
  String? _errorMessage;
  Timer? _pollingTimer;

  // Getters
  HomeStatus get status => _status;
  Employee? get employee => _employee;
  List<MenuItem> get hierarchicalMenus => _hierarchicalMenus;
  NotificationCount? get notificationCount => _notificationCount;
  Kpi? get kpi => _kpi;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == HomeStatus.loading;
  bool get hasError => _status == HomeStatus.error;

  /// Load all home data (employee profile, menus, notification count, KPI)
  Future<void> loadHomeData() async {
    _status = HomeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    // Load employee profile
    final profileResult = await getEmployeeProfile(NoParams());

    profileResult.fold(
      (failure) {
        _status = HomeStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return;
      },
      (employee) {
        _employee = employee;
      },
    );

    // Load hierarchical menus (cache-first, but always check for updates)
    await loadHierarchicalMenus();

    // Load KPI Summary (Current Month)
    await refreshKpiSummary();

    // Load notification count
    await refreshNotificationCount();

    _status = HomeStatus.loaded;
    notifyListeners();
  }

  /// Start polling for notifications
  void startPolling() {
    stopPolling();
    // Initial fetch
    refreshNotificationCount();
    // Poll every 30 seconds
    _pollingTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      refreshNotificationCount();
    });
  }

  /// Stop polling for notifications
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  /// Refresh notification count only
  Future<void> refreshNotificationCount() async {
    final result = await getNotificationCount(NoParams());

    result.fold(
      (failure) {
        // Don't change status, just log error
        debugPrint('Failed to refresh notification count: ${failure.message}');
      },
      (notificationCount) {
        _notificationCount = notificationCount;
        notifyListeners();
      },
    );
  }

  /// Refresh KPI Summary
  Future<void> refreshKpiSummary() async {
    final now = DateTime.now();
    final result = await getKpiSummary(
      KpiParams(month: now.month, year: now.year),
    );

    result.fold(
      (failure) {
        debugPrint('Failed to refresh KPI summary: ${failure.message}');
      },
      (kpi) {
        _kpi = kpi;
        notifyListeners();
      },
    );
  }

  /// Refresh all data
  Future<void> refresh() async {
    await loadHomeData();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Load hierarchical menus (with caching)
  /// This method uses cache-first strategy and should be called once on app start
  Future<void> loadHierarchicalMenus() async {
    final result = await getHierarchicalMenus(NoParams());

    result.fold(
      (failure) {
        debugPrint('Failed to load hierarchical menus: ${failure.message}');
        _errorMessage = failure.message;
      },
      (menus) {
        _hierarchicalMenus = menus;
        notifyListeners();
      },
    );
  }

  /// Find menu by code (recursive search)
  /// Returns the menu item with the matching code, or null if not found
  MenuItem? findMenuByCode(String code) {
    return _findMenuByCodeRecursive(_hierarchicalMenus, code);
  }

  /// Recursive helper method to find menu by code
  MenuItem? _findMenuByCodeRecursive(List<MenuItem> menus, String code) {
    for (final menu in menus) {
      if (menu.code == code) {
        return menu;
      }
      if (menu.children != null && menu.children!.isNotEmpty) {
        final found = _findMenuByCodeRecursive(menu.children!, code);
        if (found != null) return found;
      }
    }
    return null;
  }

  /// Get children of a menu by code
  /// Returns empty list if menu not found or has no children
  List<MenuItem> getChildrenByCode(String code) {
    final menu = findMenuByCode(code);
    return menu?.children ?? [];
  }

  /// Refresh hierarchical menus (force reload from API)
  Future<void> refreshHierarchicalMenus() async {
    await loadHierarchicalMenus();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
