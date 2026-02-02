import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/forgot_password_status.dart';
import '../entities/forgot_password_verification_data.dart';

abstract class ForgotPasswordRepository {
  Future<Either<Failure, ForgotPasswordStatus>> sendOtp(String email);
  Future<Either<Failure, ForgotPasswordVerificationData>> verifyOtp(String email, String code);
  Future<Either<Failure, void>> resetPassword(
    int id,
    String oldPassword, // Note: v1 seems to send old_password but it might be from verifying OTP? Let's check v1 model/logic again.
    // In v1 ModelVerifOtpForgetPassword:
    // class Data { int employeeId; String oldPassword; ... }
    // So verifyOtp returns the ID and "oldPassword" (likely a temp token or hash).
    String password,
    String confirmationPassword,
  );
}
