import 'package:equatable/equatable.dart';
import 'kpi_indicator.dart';
import 'kpi_role_indicator.dart';

/// Aggregate entity holding all KPI indicator groups
class KpiIndicatorsData extends Equatable {
  final List<KpiIndicator> attendance;
  final List<KpiIndicator> supervisorAssessment;
  final List<KpiIndicator> targetPoint;
  final List<KpiRoleIndicator> task;
  final List<KpiRoleIndicator> workPlan;

  const KpiIndicatorsData({
    required this.attendance,
    required this.supervisorAssessment,
    required this.targetPoint,
    required this.task,
    required this.workPlan,
  });

  @override
  List<Object?> get props => [attendance, supervisorAssessment, targetPoint, task, workPlan];
}
