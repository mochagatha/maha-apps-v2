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

  /// Get notification counts
  Future<Either<Failure, NotificationCount>> getNotificationCount();

  /// Get KPI summary
  Future<Either<Failure, Kpi>> getKpiSummary({
    required int month,
    required int year,
  });
}
