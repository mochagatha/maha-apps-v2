import '../../domain/entities/user_role_entity.dart';

class UserRoleModel extends UserRoleEntity {
  const UserRoleModel({
    required super.id,
    required super.name,
    super.supervisorRoleId,
    super.subordinates = const [],
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) {
    return UserRoleModel(
      id: json['id'] as int,
      name: json['name'] as String,
      supervisorRoleId: json['supervisor_role_id'] as int?,
      subordinates: (json['subordinates'] as List<dynamic>?)
              ?.map((e) => UserRoleModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'supervisor_role_id': supervisorRoleId,
      'subordinates': subordinates
          .map((e) => (e as UserRoleModel).toJson())
          .toList(),
    };
  }

  UserRoleEntity toEntity() {
    return UserRoleEntity(
      id: id,
      name: name,
      supervisorRoleId: supervisorRoleId,
      subordinates: subordinates,
    );
  }
}
