import '../../domain/entities/role_structure_entity.dart';
import 'employment_level_model.dart';
import 'superior_employee_model.dart';

class RoleStructureModel extends RoleStructureEntity {
  const RoleStructureModel({
    required super.id,
    required super.userRoleId,
    required super.companyStructureId,
    required super.userRole,
    required super.superiorEmployeeStructure,
  });

  factory RoleStructureModel.fromJson(Map<String, dynamic> json) {
    return RoleStructureModel(
      id: json['id'] as int,
      userRoleId: json['user_role_id'] as int,
      companyStructureId: json['company_structure_id'] as int,
      userRole: EmploymentLevelModel.fromJson(json['user_role'] as Map<String, dynamic>),
      superiorEmployeeStructure: (json['superior_employee_structure'] as List)
          .map((e) => SuperiorEmployeeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_role_id': userRoleId,
      'company_structure_id': companyStructureId,
      'user_role': (userRole as EmploymentLevelModel).toJson(),
      'superior_employee_structure': superiorEmployeeStructure
          .map((e) => (e as SuperiorEmployeeModel).toJson())
          .toList(),
    };
  }

  RoleStructureEntity toEntity() {
    return RoleStructureEntity(
      id: id,
      userRoleId: userRoleId,
      companyStructureId: companyStructureId,
      userRole: userRole,
      superiorEmployeeStructure: superiorEmployeeStructure,
    );
  }
}
