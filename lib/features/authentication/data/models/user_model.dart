// User Model - extends User entity with JSON serialization
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    int? employeeId,
    int? jobTitleId,
    String? branchCode,
    int? status,
    String? token,
    String? refreshToken,
  }) : super(
          employeeId: employeeId,
          jobTitleId: jobTitleId,
          branchCode: branchCode,
          status: status,
          token: token,
          refreshToken: refreshToken,
        );

  // From JSON (matching v1 structure)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      employeeId: json['employee_id'] as int?,
      jobTitleId: json['job_title_id'] as int?,
      branchCode: json['branch_code'] as String?,
      status: json['status'] as int?,
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'employee_id': employeeId,
      'job_title_id': jobTitleId,
      'branch_code': branchCode,
      'status': status,
      'token': token,
      'refresh_token': refreshToken,
    };
  }

  // Convert to entity
  User toEntity() {
    return User(
      employeeId: employeeId,
      jobTitleId: jobTitleId,
      branchCode: branchCode,
      status: status,
      token: token,
      refreshToken: refreshToken,
    );
  }

  // From entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      employeeId: user.employeeId,
      jobTitleId: user.jobTitleId,
      branchCode: user.branchCode,
      status: user.status,
      token: user.token,
      refreshToken: user.refreshToken,
    );
  }
}
