import '../../domain/entities/forgot_password_verification_data.dart';

class ForgotPasswordVerificationDataModel extends ForgotPasswordVerificationData {
  final String status;
  final int code;
  final String message;

  const ForgotPasswordVerificationDataModel({
    required this.status,
    required this.code,
    required this.message,
    required super.employeeId,
    required super.oldPassword,
  });

  factory ForgotPasswordVerificationDataModel.fromJson(Map<String, dynamic> json) {
    // Match v1 structure: {status, code, message, data: {employee_id, old_password}}
    final data = json['data'];
    return ForgotPasswordVerificationDataModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      employeeId: data['employee_id'],
      oldPassword: data['old_password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': {'employee_id': employeeId, 'old_password': oldPassword},
    };
  }
}
