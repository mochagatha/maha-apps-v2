import 'package:equatable/equatable.dart';
import 'role_structure_entity.dart';

class OrganizationalStructureEntity extends Equatable {
  final int id;
  final String typeStructure;
  final List<RoleStructureEntity> roleStructure;

  const OrganizationalStructureEntity({
    required this.id,
    required this.typeStructure,
    required this.roleStructure,
  });

  @override
  List<Object?> get props => [id, typeStructure, roleStructure];
}
