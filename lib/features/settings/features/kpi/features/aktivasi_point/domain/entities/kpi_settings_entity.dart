import 'package:equatable/equatable.dart';
import 'employee_kpi_entity.dart';

/// KPI Settings entity representing the overall KPI activation settings
class KpiSettings extends Equatable {
  final List<EmployeeKpi> employees;
  final bool isActive;

  const KpiSettings({
    required this.employees,
    required this.isActive,
  });

  @override
  List<Object?> get props => [employees, isActive];
}
