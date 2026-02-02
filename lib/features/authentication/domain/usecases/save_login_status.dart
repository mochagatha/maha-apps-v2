import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class SaveLoginStatus implements UseCase<void, SaveLoginStatusParams> {
  final AuthRepository repository;

  SaveLoginStatus(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveLoginStatusParams params) async {
    return await repository.saveLoginStatus(params.rememberMe);
  }
}

class SaveLoginStatusParams {
  final bool rememberMe;

  const SaveLoginStatusParams({required this.rememberMe});
}
