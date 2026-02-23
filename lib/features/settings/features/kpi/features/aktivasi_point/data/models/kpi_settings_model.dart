import '../../domain/entities/kpi_settings_entity.dart';
import 'employee_kpi_model.dart';

/// Model for KPI Settings that extends the domain entity
/// Handles JSON serialization/deserialization for API compatibility
class KpiSettingsModel extends KpiSettings {
  const KpiSettingsModel({
    required super.employees,
    required super.isActive,
  });

  /// Create KpiSettingsModel from JSON (V1 API compatible)
  factory KpiSettingsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> employeeJson = json['employee'] ?? [];
    final List<EmployeeKpiModel> employees = employeeJson
        .map((e) => EmployeeKpiModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return KpiSettingsModel(
      employees: employees,
      isActive: json['is_active'] ?? false,
    );
  }

  /// Convert KpiSettingsModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'employee': employees
          .map(
            (e) => EmployeeKpiModel(
              id: e.id,
              nik: e.nik,
              fullname: e.fullname,
              photoUrl: e.photoUrl,
              statusLabel: e.statusLabel,
              isKpiActive: e.isKpiActive,
              departmentName: e.departmentName,
              jobTitle: e.jobTitle,
            ).toJson(),
          )
          .toList(),
      'is_active': isActive,
    };
  }

  /// Convert model to entity
  KpiSettings toEntity() {
    return KpiSettings(
      employees: employees,
      isActive: isActive,
    );
  }
}
