// Auth Response Entity
import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResponse extends Equatable {
  final String? status;
  final int? code;
  final String? message;
  final User data;

  const AuthResponse({
    this.status,
    this.code,
    this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, code, message, data];
}
