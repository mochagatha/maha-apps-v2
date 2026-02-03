import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/access_menu_repository.dart';

/// Use case to manage employee menu access (create and delete)
class ManageMenuAccess {
  final AccessMenuRepository repository;

  ManageMenuAccess(this.repository);

  /// Assign menus to an employee
  /// [employeeId] - ID of the employee
  /// [menuIds] - List of menu IDs to assign
  Future<Either<Failure, void>> createMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    return await repository.createEmployeeMenus(
      employeeId: employeeId,
      menuIds: menuIds,
    );
  }

  /// Remove menus from an employee
  /// [employeeId] - ID of the employee
  /// [menuIds] - List of menu IDs to remove
  Future<Either<Failure, void>> deleteMenus({
    required int employeeId,
    required List<int> menuIds,
  }) async {
    return await repository.deleteEmployeeMenus(
      employeeId: employeeId,
      menuIds: menuIds,
    );
  }
}
