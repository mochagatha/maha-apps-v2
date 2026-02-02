import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/forgot_password_repository.dart';
import '../entities/forgot_password_verification_data.dart';

class VerifyOtp extends UseCase<ForgotPasswordVerificationData, VerifyOtpParams> {
  final ForgotPasswordRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, ForgotPasswordVerificationData>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.email, params.code);
  }
}

class VerifyOtpParams extends Equatable {
  final String email;
  final String code;

  const VerifyOtpParams({required this.email, required this.code});

  @override
  List<Object> get props => [email, code];
}
