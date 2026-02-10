import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/menu_item.dart';
import '../repositories/home_repository.dart';

/// Use case for getting hierarchical employee menus with caching
/// 
/// This use case implements a cache-first strategy:
/// 1. Checks if valid cached data exists
/// 2. Returns cached data if valid
/// 3. Fetches from API if cache is invalid or doesn't exist
/// 4. Caches the API response for future use
class GetHierarchicalMenus implements UseCase<List<MenuItem>, NoParams> {
  final HomeRepository repository;

  GetHierarchicalMenus(this.repository);

  @override
  Future<Either<Failure, List<MenuItem>>> call(NoParams params) async {
    return await repository.getHierarchicalMenus();
  }
}
