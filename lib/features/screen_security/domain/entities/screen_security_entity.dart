import 'package:equatable/equatable.dart';

class ScreenSecurityEntity extends Equatable {
  final int id;
  final int employeeWorkerId;
  final bool isRecord;
  final bool isCatch;
  final String type;
  final EmployeeInfo? employee;

  const ScreenSecurityEntity({
    required this.id,
    required this.employeeWorkerId,
    required this.isRecord,
    required this.isCatch,
    required this.type,
    this.employee,
  });

  @override
  List<Object?> get props => [id, employeeWorkerId, isRecord, isCatch, type, employee];
}

class EmployeeInfo extends Equatable {
  final int id;
  final String nik;
  final String fullname;
  final String photoUrl;
  final String statusLabel;
  final DepartmentInfo? department;
  final JobTitleInfo? jobTitle;

  const EmployeeInfo({
    required this.id,
    required this.nik,
    required this.fullname,
    required this.photoUrl,
    required this.statusLabel,
    this.department,
    this.jobTitle,
  });

  @override
  List<Object?> get props => [id, nik, fullname, photoUrl, statusLabel, department, jobTitle];
}

class DepartmentInfo extends Equatable {
  final String departmentName;

  const DepartmentInfo({required this.departmentName});

  @override
  List<Object?> get props => [departmentName];
}

class JobTitleInfo extends Equatable {
  final String name;

  const JobTitleInfo({required this.name});

  @override
  List<Object?> get props => [name];
}
