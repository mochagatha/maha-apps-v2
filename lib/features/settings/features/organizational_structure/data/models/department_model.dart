import '../../domain/entities/department_entity.dart';

class DepartmentModel extends DepartmentEntity {
  const DepartmentModel({
    required super.id,
    required super.departmentCode,
    required super.departmentName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      id: json['id'] as int,
      departmentCode: json['department_code'] as String,
      departmentName: json['department_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department_code': departmentCode,
      'department_name': departmentName,
    };
  }

  DepartmentEntity toEntity() {
    return DepartmentEntity(
      id: id,
      departmentCode: departmentCode,
      departmentName: departmentName,
    );
  }
}
