import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/menu_access_entity.dart';
import '../repositories/access_menu_repository.dart';

/// Use case to fetch all available menu items in the system
class GetAllMenus {
  final AccessMenuRepository repository;

  GetAllMenus(this.repository);

  /// Execute the use case
  /// Returns Either<Failure, List<MenuAccessEntity>>
  Future<Either<Failure, List<MenuAccessEntity>>> call() async {
    return await repository.getAllMenus();
  }
}
