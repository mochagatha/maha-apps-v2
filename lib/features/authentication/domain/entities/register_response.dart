import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final bool success;
  final String message;
  final String? token;

  const RegisterResponse({
    required this.success,
    required this.message,
    this.token,
  });

  @override
  List<Object?> get props => [success, message, token];
}
