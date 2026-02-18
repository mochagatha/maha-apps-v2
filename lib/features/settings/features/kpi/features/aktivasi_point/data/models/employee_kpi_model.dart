import '../../domain/entities/employee_kpi_entity.dart';

/// Model for Employee KPI that extends the domain entity
/// Handles JSON serialization/deserialization for API compatibility
class EmployeeKpiModel extends EmployeeKpi {
  const EmployeeKpiModel({
    required super.id,
    required super.nik,
    required super.fullname,
    super.photoUrl,
    required super.statusLabel,
    required super.isKpiActive,
    required super.departmentName,
    required super.jobTitle,
  });

  /// Create EmployeeKpiModel from JSON (V1 API compatible)
  factory EmployeeKpiModel.fromJson(Map<String, dynamic> json) {
    return EmployeeKpiModel(
      id: json['id'] as int,
      nik: json['nik'] as String,
      fullname: json['fullname'] as String,
      photoUrl: json['photo_url'] as String?,
      statusLabel: json['status_label'] as String,
      isKpiActive: json['kpi_setting']?['is_active'] ?? false,
      departmentName: json['department']?['department_name'] ?? '',
      jobTitle: json['job_title']?['name'] ?? '',
    );
  }

  /// Convert EmployeeKpiModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nik': nik,
      'fullname': fullname,
      'photo_url': photoUrl,
      'status_label': statusLabel,
      'kpi_setting': {
        'is_active': isKpiActive,
      },
      'department': {
        'department_name': departmentName,
      },
      'job_title': {
        'name': jobTitle,
      },
    };
  }

  /// Convert model to entity
  EmployeeKpi toEntity() {
    return EmployeeKpi(
      id: id,
      nik: nik,
      fullname: fullname,
      photoUrl: photoUrl,
      statusLabel: statusLabel,
      isKpiActive: isKpiActive,
      departmentName: departmentName,
      jobTitle: jobTitle,
    );
  }
}
