import '../../domain/entities/department_structure_entity.dart';
import 'department_model.dart';
import 'employee_model.dart';

class DepartmentStructureModel extends DepartmentStructureEntity {
  const DepartmentStructureModel({
    required super.id,
    required super.department,
    required super.employeeStructure,
    required super.workerStructure,
  });

  factory DepartmentStructureModel.fromJson(Map<String, dynamic> json) {
    return DepartmentStructureModel(
      id: json['id'] as int,
      department: DepartmentModel.fromJson(json['department'] as Map<String, dynamic>),
      employeeStructure: (json['employee_structure'] as List)
          .map((e) => EmployeeStructureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      workerStructure: (json['worker_structure'] as List)
          .map((e) => WorkerStructureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'department': (department as DepartmentModel).toJson(),
      'employee_structure': employeeStructure
          .map((e) => (e as EmployeeStructureModel).toJson())
          .toList(),
      'worker_structure': workerStructure
          .map((e) => (e as WorkerStructureModel).toJson())
          .toList(),
    };
  }

  DepartmentStructureEntity toEntity() {
    return DepartmentStructureEntity(
      id: id,
      department: department,
      employeeStructure: employeeStructure,
      workerStructure: workerStructure,
    );
  }
}

class EmployeeStructureModel extends EmployeeStructureEntity {
  const EmployeeStructureModel({
    required super.id,
    required super.employee,
  });

  factory EmployeeStructureModel.fromJson(Map<String, dynamic> json) {
    return EmployeeStructureModel(
      id: json['id'] as int,
      employee: EmployeeModel.fromJson(json['employee'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee': (employee as EmployeeModel).toJson(),
    };
  }

  EmployeeStructureEntity toEntity() {
    return EmployeeStructureEntity(
      id: id,
      employee: employee,
    );
  }
}

class WorkerStructureModel extends WorkerStructureEntity {
  const WorkerStructureModel({
    required super.id,
    required super.worker,
  });

  factory WorkerStructureModel.fromJson(Map<String, dynamic> json) {
    return WorkerStructureModel(
      id: json['id'] as int,
      worker: EmployeeModel.fromJson(json['worker'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'worker': (worker as EmployeeModel).toJson(),
    };
  }

  WorkerStructureEntity toEntity() {
    return WorkerStructureEntity(
      id: id,
      worker: worker,
    );
  }
}
