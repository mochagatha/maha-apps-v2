import 'package:equatable/equatable.dart';

/// Employee KPI entity representing an employee with KPI activation settings
class EmployeeKpi extends Equatable {
  final int id;
  final String nik;
  final String fullname;
  final String? photoUrl;
  final String statusLabel;
  final bool isKpiActive;
  final String departmentName;
  final String jobTitle;

  const EmployeeKpi({
    required this.id,
    required this.nik,
    required this.fullname,
    this.photoUrl,
    required this.statusLabel,
    required this.isKpiActive,
    required this.departmentName,
    required this.jobTitle,
  });

  @override
  List<Object?> get props => [
    id,
    nik,
    fullname,
    photoUrl,
    statusLabel,
    isKpiActive,
    departmentName,
    jobTitle,
  ];
}
