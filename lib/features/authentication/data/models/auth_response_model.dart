// Auth Response Model - extends AuthResponse entity with JSON serialization
import '../../domain/entities/auth_response.dart';
import 'user_model.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({
    String? status,
    int? code,
    String? message,
    required UserModel data,
  }) : super(
          status: status,
          code: code,
          message: message,
          data: data,
        );

  // From JSON (matching v1 ModelSignIn structure)
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      status: json['status'] as String?,
      code: json['code'] as int?,
      message: json['message'] as String?,
      data: UserModel.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': (data as UserModel).toJson(),
    };
  }

  // Convert to entity
  AuthResponse toEntity() {
    return AuthResponse(
      status: status,
      code: code,
      message: message,
      data: (data as UserModel).toEntity(),
    );
  }
}
