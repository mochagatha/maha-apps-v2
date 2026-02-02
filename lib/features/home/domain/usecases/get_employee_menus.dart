import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/menu_item.dart';
import '../repositories/home_repository.dart';

class GetEmployeeMenus implements UseCase<List<MenuItem>, NoParams> {
  final HomeRepository repository;

  GetEmployeeMenus(this.repository);

  @override
  Future<Either<Failure, List<MenuItem>>> call(NoParams params) async {
    return await repository.getEmployeeMenus();
  }
}
