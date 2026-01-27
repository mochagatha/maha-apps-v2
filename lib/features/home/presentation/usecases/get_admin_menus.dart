import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/repositories/home_repository.dart';

class GetAdminMenus implements UseCase<List<MenuItem>, NoParams> {
  final HomeRepository repository;

  GetAdminMenus(this.repository);

  @override
  Future<Either<Failure, List<MenuItem>>> call(NoParams params) async {
    return await repository.getAdminMenus();
  }
}
