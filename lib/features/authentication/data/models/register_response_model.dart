import '../entities/register_response.dart';

class RegisterResponseModel extends RegisterResponse {
  const RegisterResponseModel({
    required bool success,
    required String message,
    String? token,
  }) : super(
          success: success,
          message: message,
          token: token,
        );

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? true,
      message: json['message'] ?? 'Registration successful',
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'token': token,
    };
  }

  RegisterResponse toEntity() {
    return RegisterResponse(
      success: success,
      message: message,
      token: token,
    );
  }
}
