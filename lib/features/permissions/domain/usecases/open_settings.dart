import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/permission_repository.dart';

class OpenSettings implements UseCase<void, NoParams> {
  final PermissionRepository repository;

  OpenSettings(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await repository.openSettings();
  }
}
