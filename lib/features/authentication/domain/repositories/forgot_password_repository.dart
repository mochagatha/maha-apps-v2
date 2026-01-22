import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/forgot_password_status.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordStatus>> sendOtp(String email);
  // Add other methods (verifyOtp, resetPassword) as needed in future
}
