import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/menu_access_entity.dart';

/// Repository interface for managing employee menu access
abstract class AccessMenuRepository {
  /// Get menus currently assigned to an employee
  /// Returns list of menu items with hierarchical structure
  Future<Either<Failure, List<MenuAccessEntity>>> getEmployeeMenus(
    int employeeId,
  );

  /// Get all available menu items in the system
  /// Returns complete menu hierarchy
  Future<Either<Failure, List<MenuAccessEntity>>> getAllMenus();

  /// Assign menus to an employee
  /// [employeeId] - ID of the employee
  /// [menuIds] - List of menu IDs to assign
  Future<Either<Failure, void>> createEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  });

  /// Remove menus from an employee
  /// [employeeId] - ID of the employee
  /// [menuIds] - List of menu IDs to remove
  Future<Either<Failure, void>> deleteEmployeeMenus({
    required int employeeId,
    required List<int> menuIds,
  });
}
