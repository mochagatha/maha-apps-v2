// User Model - extends User entity with JSON serialization
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    String? branchCode,
    String? token,
    String? refreshToken,
  }) : super(
          branchCode: branchCode,
          token: token,
          refreshToken: refreshToken,
        );

  // From JSON (matching v1 structure)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      branchCode: json['branch_code'] as String?,
      token: json['token'] as String?,
      refreshToken: json['refresh_token'] as String?,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'branch_code': branchCode,
      'token': token,
      'refresh_token': refreshToken,
    };
  }

  // Convert to entity
  User toEntity() {
    return User(
      branchCode: branchCode,
      token: token,
      refreshToken: refreshToken,
    );
  }

  // From entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      branchCode: user.branchCode,
      token: user.token,
      refreshToken: user.refreshToken,
    );
  }
}
