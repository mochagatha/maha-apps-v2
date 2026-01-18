// User Entity - Pure business object
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? employeeId;
  final String? branchCode;
  final String? token;
  final String? refreshToken;

  const User({
    this.employeeId,
    this.branchCode,
    this.token,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [employeeId, branchCode, token, refreshToken];

  // Helper method to check if user is authenticated
  bool get isAuthenticated => token != null && token!.isNotEmpty;
}
