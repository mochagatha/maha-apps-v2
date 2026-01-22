import 'package:equatable/equatable.dart';

class ForgotPasswordVerificationData extends Equatable {
  final int employeeId;
  final String oldPassword;

  const ForgotPasswordVerificationData({
    required this.employeeId,
    required this.oldPassword,
  });

  @override
  List<Object?> get props => [employeeId, oldPassword];
}
