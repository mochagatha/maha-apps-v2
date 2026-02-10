import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/employee.dart';
import '../entities/kpi.dart';
import '../entities/menu_item.dart';
import '../entities/notification_count.dart';

abstract class HomeRepository {
  /// Get current employee profile
  Future<Either<Failure, Employee>> getEmployeeProfile();

  /// Get menu items for current employee based on role
  Future<Either<Failure, List<MenuItem>>> getEmployeeMenus();

  /// Get admin menus from API with user_type parameter
  Future<Either<Failure, List<MenuItem>>> getAdminMenus();

  /// Get hierarchical employee menus with caching
  /// Uses cache-first strategy: returns cached data if valid, otherwise fetches from API
  Future<Either<Failure, List<MenuItem>>> getHierarchicalMenus();

  /// Get notification counts
  Future<Either<Failure, NotificationCount>> getNotificationCount();

  /// Get KPI summary
  Future<Either<Failure, Kpi>> getKpiSummary({required int month, required int year});
}
