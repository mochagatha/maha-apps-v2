import 'package:flutter/material.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/usecases/reset_password.dart';
import '../../domain/entities/forgot_password_verification_data.dart';

enum ForgotPasswordState { initial, loading, success, error }

class ForgotPasswordProvider extends ChangeNotifier {
  final SendOtp sendOtpUseCase;
  final VerifyOtp verifyOtpUseCase;
  final ResetPassword resetPasswordUseCase;

  ForgotPasswordProvider({
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
    required this.resetPasswordUseCase,
  });

  ForgotPasswordState _state = ForgotPasswordState.initial;
  ForgotPasswordState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  ForgotPasswordVerificationData? _verificationData;
  ForgotPasswordVerificationData? get verificationData => _verificationData;

  void validateEmail(String email) {
    // Basic email validation regex
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    _isButtonEnabled = email.isNotEmpty && emailRegex.hasMatch(email);
    notifyListeners();
  }

  Future<void> sendOtp(String email) async {
    _state = ForgotPasswordState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await sendOtpUseCase(SendOtpParams(email: email));

    result.fold(
      (failure) {
        _state = ForgotPasswordState.error;
        _errorMessage = failure.message;
      },
      (success) {
        _state = ForgotPasswordState.success;
      },
    );

    notifyListeners();
  }

  Future<void> verifyOtp(String email, String code) async {
    _state = ForgotPasswordState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await verifyOtpUseCase(
      VerifyOtpParams(email: email, code: code),
    );

    result.fold(
      (failure) {
        _state = ForgotPasswordState.error;
        _errorMessage = failure.message;
      },
      (data) {
        _state = ForgotPasswordState.success;
        _verificationData = data;
      },
    );

    notifyListeners();
  }

  Future<void> resetPassword(
    String password,
    String confirmationPassword,
  ) async {
    print('🔄 Provider: resetPassword called');
    print(
      '  Verification Data: ${_verificationData != null ? "EXISTS" : "NULL"}',
    );

    if (_verificationData == null) {
      print('❌ Provider: Missing verification data');
      _state = ForgotPasswordState.error;
      _errorMessage = "Missing verification data";
      notifyListeners();
      return;
    }

    print('  Employee ID: ${_verificationData!.employeeId}');
    print(
      '  Old Password: ${_verificationData!.oldPassword.isNotEmpty ? "EXISTS" : "EMPTY"}',
    );
    print('  New Password Length: ${password.length}');
    print('  Confirmation Password Length: ${confirmationPassword.length}');

    _state = ForgotPasswordState.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await resetPasswordUseCase(
      ResetPasswordParams(
        id: _verificationData!.employeeId,
        oldPassword: _verificationData!.oldPassword,
        password: password,
        confirmationPassword: confirmationPassword,
      ),
    );

    result.fold(
      (failure) {
        print('❌ Provider: Reset password failed - ${failure.message}');
        _state = ForgotPasswordState.error;
        _errorMessage = failure.message;
      },
      (success) {
        print('✅ Provider: Reset password successful');
        _state = ForgotPasswordState.success;
      },
    );

    notifyListeners();
  }

  void resetState() {
    _state = ForgotPasswordState.initial;
    _errorMessage = null;
    _isButtonEnabled = false;
    _verificationData = null;
    notifyListeners();
  }
}
