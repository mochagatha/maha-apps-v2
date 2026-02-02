import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/notification_count.dart';
import '../../domain/usecases/get_notification_count.dart';
import '../usecases/get_admin_menus.dart';

enum AdminHomeStatus { initial, loading, loaded, error }

class AdminHomeProvider extends ChangeNotifier {
  final GetAdminMenus getAdminMenus;
  final GetNotificationCount getNotificationCount;

  AdminHomeProvider({required this.getAdminMenus, required this.getNotificationCount});

  AdminHomeStatus _status = AdminHomeStatus.initial;
  List<MenuItem> _menus = [];
  NotificationCount? _notificationCount;
  String? _errorMessage;
  Timer? _pollingTimer;

  // Getters
  AdminHomeStatus get status => _status;
  List<MenuItem> get menus => _menus;
  NotificationCount? get notificationCount => _notificationCount;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _status == AdminHomeStatus.loading;
  bool get hasError => _status == AdminHomeStatus.error;

  /// Load all admin home data (menus, notification count)
  Future<void> loadHomeData() async {
    _status = AdminHomeStatus.loading;
    _errorMessage = null;
    notifyListeners();

    // Load menus with admin user_type
    final menusResult = await getAdminMenus(NoParams());

    menusResult.fold(
      (failure) {
        _status = AdminHomeStatus.error;
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

    _status = AdminHomeStatus.loaded;
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
