import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/forgot_password_repository.dart';

class ResetPassword extends UseCase<void, ResetPasswordParams> {
  final ForgotPasswordRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, void>> call(ResetPasswordParams params) async {
    return await repository.resetPassword(
      params.id,
      params.oldPassword,
      params.password,
      params.confirmationPassword,
    );
  }
}

class ResetPasswordParams extends Equatable {
  final int id;
  final String oldPassword;
  final String password;
  final String confirmationPassword;

  const ResetPasswordParams({
    required this.id,
    required this.oldPassword,
    required this.password,
    required this.confirmationPassword,
  });

  @override
  List<Object> get props => [id, oldPassword, password, confirmationPassword];
}
