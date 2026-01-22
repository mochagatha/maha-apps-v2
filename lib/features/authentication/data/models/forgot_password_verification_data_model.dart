import '../../domain/entities/forgot_password_verification_data.dart';

class ForgotPasswordVerificationDataModel extends ForgotPasswordVerificationData {
  const ForgotPasswordVerificationDataModel({
    required super.employeeId,
    required super.oldPassword,
  });

  factory ForgotPasswordVerificationDataModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    // Handle case where data might be null or fields different, but assuming v1 structure matches
    return ForgotPasswordVerificationDataModel(
      employeeId: data['employee_id'],
      oldPassword: data['old_password'],
    );
  }
}
