import '../../domain/entities/superior_employee_entity.dart';
import 'department_model.dart';
import 'department_structure_model.dart';
import 'employee_model.dart';
import 'job_title_model.dart';

class SuperiorEmployeeModel extends SuperiorEmployeeEntity {
  const SuperiorEmployeeModel({
    required super.id,
    required super.employee,
    required super.department,
    required super.jobTitle,
    required super.departmentStructure,
  });

  factory SuperiorEmployeeModel.fromJson(Map<String, dynamic> json) {
    return SuperiorEmployeeModel(
      id: json['id'] as int,
      employee: EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>),
      department: DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
      jobTitle: JobTitleModel.fromJson(json['job_title'] as Map<String, dynamic>),
      departmentStructure: (json['department_structure'] as List? ?? [])
          .map((e) => DepartmentStructureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': (employee as EmployeeModel).toJson(),
      'department': (department as DepartmentModel).toJson(),
      'job_title': (jobTitle as JobTitleModel).toJson(),
      'department_structure': departmentStructure
          .map((e) => (e as DepartmentStructureModel).toJson())
          .toList(),
    };
  }

  SuperiorEmployeeEntity toEntity() {
    return SuperiorEmployeeEntity(
      id: id,
      employee: employee,
      department: department,
      jobTitle: jobTitle,
      departmentStructure: departmentStructure,
    );
  }
}
