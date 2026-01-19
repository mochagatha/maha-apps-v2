import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/notification_count.dart';
import '../../domain/usecases/get_employee_menus.dart';
import '../../domain/usecases/get_employee_profile.dart';
import '../../domain/usecases/get_notification_count.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeProvider extends ChangeNotifier {
  final GetEmployeeProfile getEmployeeProfile;
  final GetEmployeeMenus getEmployeeMenus;
  final GetNotificationCount getNotificationCount;

  HomeProvider({
    required this.getEmployeeProfile,
    required this.getEmployeeMenus,
    required this.getNotificationCount,
  });

  HomeStatus _status = HomeStatus.initial;
  Employee? _employee;
  List<MenuItem> _menus = [];
  NotificationCount? _notificationCount;
  String? _errorMessage;
  Timer? _pollingTimer;

  // Getters
  HomeStatus get status => _status;
  Employee? get employee => _employee;
  List<MenuItem> get menus => _menus;
  NotificationCount? get notificationCount => _notificationCount;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == HomeStatus.loading;
  bool get hasError => _status == HomeStatus.error;

  /// Load all home data (employee profile, menus, notification count)
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

    // Load menus
    final menusResult = await getEmployeeMenus(NoParams());
    
    menusResult.fold(
      (failure) {
        _status = HomeStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return;
      },
      (menus) {
        _menus = menus;
        // Sort menus by order
        _menus.sort((a, b) => a.order.compareTo(b.order));
      },
    );

    // Load notification count
    await refreshNotificationCount();

    _status = HomeStatus.loaded;
    notifyListeners();
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

  /// Refresh all data
  Future<void> refresh() async {
    await loadHomeData();
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    stopPolling();
    super.dispose();
  }
}
