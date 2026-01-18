import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/register_response.dart';
import '../repositories/auth_repository.dart';

class Register implements UseCase<RegisterResponse, RegisterParams> {
  final AuthRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, RegisterResponse>> call(RegisterParams params) async {
    return await repository.register(
      fullname: params.fullname,
      email: params.email,
      password: params.password,
    );
  }
}

class RegisterParams {
  final String fullname;
  final String email;
  final String password;

  const RegisterParams({
    required this.fullname,
    required this.email,
    required this.password,
  });
}
