import 'package:equatable/equatable.dart';

/// KPI Role Indicator entity for Tugas (Task) and Rencana Kerja (Work Plan) items
class KpiRoleIndicator extends Equatable {
  final int id;
  final int roleId;
  final int minPoint;
  final int maxPoint;
  final String roleName;
  final String typeIndicator;

  const KpiRoleIndicator({
    required this.id,
    required this.roleId,
    required this.minPoint,
    required this.maxPoint,
    required this.roleName,
    required this.typeIndicator,
  });

  @override
  List<Object?> get props => [id, roleId, minPoint, maxPoint, roleName, typeIndicator];
}
