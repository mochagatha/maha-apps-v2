import '../../domain/entities/kpi_role_indicator.dart';

class KpiRoleIndicatorModel extends KpiRoleIndicator {
  const KpiRoleIndicatorModel({
    required super.id,
    required super.roleId,
    required super.minPoint,
    required super.maxPoint,
    required super.roleName,
    required super.typeIndicator,
  });

  factory KpiRoleIndicatorModel.fromJson(Map<String, dynamic> json) {
    return KpiRoleIndicatorModel(
      id: json['id'] ?? 0,
      roleId: json['role_id'] ?? 0,
      minPoint: json['min_point'] is int
          ? json['min_point'] as int
          : int.tryParse(json['min_point'].toString()) ?? 0,
      maxPoint: json['max_point'] is int
          ? json['max_point'] as int
          : int.tryParse(json['max_point'].toString()) ?? 0,
      roleName: json['role_name'] ?? '',
      typeIndicator: json['type_indicator'] ?? '',
    );
  }

  KpiRoleIndicator toEntity() => KpiRoleIndicator(
    id: id,
    roleId: roleId,
    minPoint: minPoint,
    maxPoint: maxPoint,
    roleName: roleName,
    typeIndicator: typeIndicator,
  );
}
