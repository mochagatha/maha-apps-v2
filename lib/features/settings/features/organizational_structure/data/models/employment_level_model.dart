import '../../domain/entities/employment_level_entity.dart';

class EmploymentLevelModel extends EmploymentLevelEntity {
  const EmploymentLevelModel({
    required super.id,
    required super.name,
    required super.typeRole,
  });

  factory EmploymentLevelModel.fromJson(Map<String, dynamic> json) {
    return EmploymentLevelModel(
      id: json['id'] as int,
      name: json['name'] as String,
      typeRole: json['type_role'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type_role': typeRole,
    };
  }

  EmploymentLevelEntity toEntity() {
    return EmploymentLevelEntity(
      id: id,
      name: name,
      typeRole: typeRole,
    );
  }
}
