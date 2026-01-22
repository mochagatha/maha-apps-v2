import '../../domain/entities/forgot_password_status.dart';

class ForgotPasswordStatusModel extends ForgotPasswordStatus {
  const ForgotPasswordStatusModel({
    required super.status,
    required super.code,
    required super.message,
  });

  factory ForgotPasswordStatusModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordStatusModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
    };
  }
}
