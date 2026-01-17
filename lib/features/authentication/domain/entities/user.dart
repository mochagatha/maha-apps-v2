// User Entity - Pure business object
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? branchCode;
  final String? token;
  final String? refreshToken;

  const User({
    this.branchCode,
    this.token,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [branchCode, token, refreshToken];

  // Helper method to check if user is authenticated
  bool get isAuthenticated => token != null && token!.isNotEmpty;
}
