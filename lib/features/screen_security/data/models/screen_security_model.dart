import '../../domain/entities/screen_security_entity.dart';

class ScreenSecurityModel extends ScreenSecurityEntity {
  const ScreenSecurityModel({
    required super.id,
    required super.employeeWorkerId,
    required super.isRecord,
    required super.isCatch,
    required super.type,
    super.employee,
  });

  factory ScreenSecurityModel.fromJson(Map<String, dynamic> json) {
    return ScreenSecurityModel(
      id: json['id'] ?? 0,
      employeeWorkerId: json['employee_worker_id'] ?? 0,
      isRecord: json['is_record'] ?? false,
      isCatch: json['is_catch'] ?? false,
      type: json['type'] ?? '',
      employee: json['employee'] != null ? EmployeeInfoModel.fromJson(json['employee']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_worker_id': employeeWorkerId,
      'is_record': isRecord,
      'is_catch': isCatch,
      'type': type,
      'employee': employee != null ? (employee as EmployeeInfoModel).toJson() : null,
    };
  }
}

class EmployeeInfoModel extends EmployeeInfo {
  const EmployeeInfoModel({
    required super.id,
    required super.nik,
    required super.fullname,
    required super.photoUrl,
    required super.statusLabel,
    super.department,
    super.jobTitle,
  });

  factory EmployeeInfoModel.fromJson(Map<String, dynamic> json) {
    return EmployeeInfoModel(
      id: json['id'] ?? 0,
      nik: json['nik'] ?? '',
      fullname: json['fullname'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      statusLabel: json['status_label'] ?? '',
      department: json['department'] != null
          ? DepartmentInfoModel.fromJson(json['department'])
          : null,
      jobTitle: json['job_title'] != null ? JobTitleInfoModel.fromJson(json['job_title']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nik': nik,
      'fullname': fullname,
      'photo_url': photoUrl,
      'status_label': statusLabel,
      'department': department != null ? (department as DepartmentInfoModel).toJson() : null,
      'job_title': jobTitle != null ? (jobTitle as JobTitleInfoModel).toJson() : null,
    };
  }
}

class DepartmentInfoModel extends DepartmentInfo {
  const DepartmentInfoModel({required super.departmentName});

  factory DepartmentInfoModel.fromJson(Map<String, dynamic> json) {
    return DepartmentInfoModel(departmentName: json['department_name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'department_name': departmentName};
  }
}

class JobTitleInfoModel extends JobTitleInfo {
  const JobTitleInfoModel({required super.name});

  factory JobTitleInfoModel.fromJson(Map<String, dynamic> json) {
    return JobTitleInfoModel(name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}
