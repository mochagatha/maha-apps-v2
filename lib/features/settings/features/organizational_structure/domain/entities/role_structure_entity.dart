import 'package:equatable/equatable.dart';
import 'employment_level_entity.dart';
import 'superior_employee_entity.dart';

class RoleStructureEntity extends Equatable {
  final int id;
  final int userRoleId;
  final int companyStructureId;
  final EmploymentLevelEntity userRole;
  final List<SuperiorEmployeeEntity> superiorEmployeeStructure;

  const RoleStructureEntity({
    required this.id,
    required this.userRoleId,
    required this.companyStructureId,
    required this.userRole,
    required this.superiorEmployeeStructure,
  });

  @override
  List<Object?> get props => [
        id,
        userRoleId,
        companyStructureId,
        userRole,
        superiorEmployeeStructure,
      ];
}
