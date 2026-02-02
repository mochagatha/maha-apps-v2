// User Entity - Pure business object
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? employeeId;
  final int? jobTitleId;
  final String? branchCode;
  final int? status;
  final String? token;
  final String? refreshToken;

  const User({
    this.employeeId,
    this.jobTitleId,
    this.branchCode,
    this.status,
    this.token,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [employeeId, jobTitleId, branchCode, status, token, refreshToken];

  // Helper method to check if user is authenticated
  bool get isAuthenticated => token != null && token!.isNotEmpty;
}
