import '../../domain/entities/organizational_structure_entity.dart';
import 'role_structure_model.dart';

class OrganizationalStructureModel extends OrganizationalStructureEntity {
  const OrganizationalStructureModel({
    required super.id,
    required super.typeStructure,
    required super.roleStructure,
  });

  factory OrganizationalStructureModel.fromJson(Map<String, dynamic> json) {
    return OrganizationalStructureModel(
      id: json['id'] as int,
      typeStructure: json['type_structure'] as String,
      roleStructure: (json['role_structure'] as List? ?? [])
          .map((e) => RoleStructureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type_structure': typeStructure,
      'role_structure': roleStructure.map((e) => (e as RoleStructureModel).toJson()).toList(),
    };
  }

  OrganizationalStructureEntity toEntity() {
    return OrganizationalStructureEntity(
      id: id,
      typeStructure: typeStructure,
      roleStructure: roleStructure,
    );
  }
}
