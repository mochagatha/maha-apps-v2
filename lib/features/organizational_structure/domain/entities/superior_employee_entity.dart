import 'package:equatable/equatable.dart';
import 'department_entity.dart';
import 'department_structure_entity.dart';
import 'employee_entity.dart';
import 'job_title_entity.dart';

class SuperiorEmployeeEntity extends Equatable {
  final int id;
  final EmployeeEntity employee;
  final DepartmentEntity department;
  final JobTitleEntity jobTitle;
  final List<DepartmentStructureEntity> departmentStructure;

  const SuperiorEmployeeEntity({
    required this.id,
    required this.employee,
    required this.department,
    required this.jobTitle,
    required this.departmentStructure,
  });

  @override
  List<Object?> get props => [id, employee, department, jobTitle, departmentStructure];
}
