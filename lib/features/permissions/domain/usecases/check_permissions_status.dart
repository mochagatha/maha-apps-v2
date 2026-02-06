import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/permission_repository.dart';

class CheckPermissionsStatus implements UseCase<bool, NoParams> {
  final PermissionRepository repository;

  CheckPermissionsStatus(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkPermissions();
  }
}
