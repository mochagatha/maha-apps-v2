import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/send_otp.dart';

enum ForgotPasswordState { initial, loading, success, error }

class ForgotPasswordProvider extends ChangeNotifier {
  final SendOtp sendOtpUseCase;

  ForgotPasswordProvider({required this.sendOtpUseCase});

  ForgotPasswordState _state = ForgotPasswordState.initial;
  ForgotPasswordState get state => _state;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isButtonEnabled = false;
  bool get isButtonEnabled => _isButtonEnabled;

  void validateEmail(String email) {
    // Basic email validation regex
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );
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
    
  void resetState() {
     _state = ForgotPasswordState.initial;
     _errorMessage = null;
     _isButtonEnabled = false;
     notifyListeners();
  }
}
