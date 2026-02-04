import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/permission_repository.dart';

class GetDeniedPermissionsDetail implements UseCase<Map<String, bool>, NoParams> {
  final PermissionRepository repository;

  GetDeniedPermissionsDetail(this.repository);

  @override
  Future<Either<Failure, Map<String, bool>>> call(NoParams params) async {
    return await repository.getDeniedPermissionsDetail();
  }
}
