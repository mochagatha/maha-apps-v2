import 'package:equatable/equatable.dart';

class ForgotPasswordStatus extends Equatable {
  final String status;
  final int code;
  final String message;

  const ForgotPasswordStatus({
    required this.status,
    required this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [status, code, message];
}
