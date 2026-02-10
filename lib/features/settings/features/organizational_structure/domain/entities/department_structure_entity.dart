import 'package:equatable/equatable.dart';
import 'department_entity.dart';
import 'employee_entity.dart';

class DepartmentStructureEntity extends Equatable {
  final int id;
  final DepartmentEntity department;
  final List<EmployeeStructureEntity> employeeStructure;
  final List<WorkerStructureEntity> workerStructure;

  const DepartmentStructureEntity({
    required this.id,
    required this.department,
    required this.employeeStructure,
    required this.workerStructure,
  });

  @override
  List<Object?> get props => [id, department, employeeStructure, workerStructure];
}

class EmployeeStructureEntity extends Equatable {
  final int id;
  final EmployeeEntity employee;

  const EmployeeStructureEntity({
    required this.id,
    required this.employee,
  });

  @override
  List<Object?> get props => [id, employee];
}

class WorkerStructureEntity extends Equatable {
  final int id;
  final EmployeeEntity worker;

  const WorkerStructureEntity({
    required this.id,
    required this.worker,
  });

  @override
  List<Object?> get props => [id, worker];
}
