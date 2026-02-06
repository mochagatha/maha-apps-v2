import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/menu_access_entity.dart';
import '../repositories/access_menu_repository.dart';

/// Use case to fetch menus currently assigned to an employee
class GetEmployeeMenus {
  final AccessMenuRepository repository;

  GetEmployeeMenus(this.repository);

  /// Execute the use case
  /// [employeeId] - ID of the employee
  /// Returns Either<Failure, List<MenuAccessEntity>>
  Future<Either<Failure, List<MenuAccessEntity>>> call(int employeeId) async {
    return await repository.getEmployeeMenus(employeeId);
  }
}
