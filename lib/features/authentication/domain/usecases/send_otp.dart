import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/forgot_password_status.dart';
import '../repositories/forgot_password_repository.dart';

class SendOtp implements UseCase<ForgotPasswordStatus, SendOtpParams> {
  final ForgotPasswordRepository repository;

  SendOtp(this.repository);

  @override
  Future<Either<Failure, ForgotPasswordStatus>> call(SendOtpParams params) async {
    return await repository.sendOtp(params.email);
  }
}

class SendOtpParams extends Equatable {
  final String email;

  const SendOtpParams({required this.email});

  @override
  List<Object?> get props => [email];
}
