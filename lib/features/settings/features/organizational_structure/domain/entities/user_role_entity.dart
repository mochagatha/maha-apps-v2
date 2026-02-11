import 'package:equatable/equatable.dart';

class UserRoleEntity extends Equatable {
  final int id;
  final String name;
  final int? supervisorRoleId;
  final List<UserRoleEntity> subordinates;

  const UserRoleEntity({
    required this.id,
    required this.name,
    this.supervisorRoleId,
    this.subordinates = const [],
  });

  @override
  List<Object?> get props => [id, name, supervisorRoleId, subordinates];
}
