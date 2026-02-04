import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/permission_repository.dart';

class IsPermissionPermanentlyDenied implements UseCase<bool, NoParams> {
  final PermissionRepository repository;

  IsPermissionPermanentlyDenied(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isPermissionPermanentlyDenied();
  }
}
