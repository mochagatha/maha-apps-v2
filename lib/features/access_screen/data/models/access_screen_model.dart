import '../../domain/entities/access_screen_entity.dart';

class AccessScreenModel extends AccessScreenGlobalEntity {
  const AccessScreenModel({
    required super.id,
    required super.isRecord,
    required super.isCatch,
    required this.employeeList,
  });

  final List<AccessScreenEmployeeModel> employeeList;

  factory AccessScreenModel.fromJson(Map<String, dynamic> json) {
    return AccessScreenModel(
      id: json['id'] ?? 0,
      isRecord: json['is_record'] ?? false,
      isCatch: json['is_catch'] ?? false,
      employeeList:
          (json['employee'] as List<dynamic>?)
              ?.map((e) => AccessScreenEmployeeModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class AccessScreenEmployeeModel extends AccessScreenEmployeeEntity {
  const AccessScreenEmployeeModel({
    required super.id,
    required super.fullname,
    required super.nik,
    required super.photoUrl,
    required super.jobTitle,
    required super.department,
    required super.branch,
    required super.isRecord,
    required super.isCatch,
  });

  factory AccessScreenEmployeeModel.fromJson(Map<String, dynamic> json) {
    return AccessScreenEmployeeModel(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      nik: json['nik'] ?? '',
      photoUrl: json['photo_url'] ?? '',
      jobTitle: json['job_title'] != null ? json['job_title']['name'] ?? '' : '',
      department: json['department'] != null ? json['department']['department_name'] ?? '' : '',
      branch: json['branch'] != null ? json['branch']['name'] ?? '' : '',
      isRecord: json['is_record'] ?? false,
      isCatch: json['is_catch'] ?? false,
    );
  }
}

class AccessScreenDetailModel extends AccessScreenDetailEntity {
  const AccessScreenDetailModel({
    required super.id,
    required super.fullname,
    required super.nik,
    required super.photoUrl,
    required super.jobTitle,
    required super.department,
    required super.branch,
    required super.isRecord,
    required super.isCatch,
  });

  factory AccessScreenDetailModel.fromJson(Map<String, dynamic> json) {
    // Data employee ada di nested field 'employee'
    final employeeData = json['employee'] ?? {};

    return AccessScreenDetailModel(
      id: json['id'] ?? 0,
      fullname: employeeData['fullname'] ?? '',
      nik: employeeData['nik']?.toString() ?? '',
      photoUrl: employeeData['photo_url'] ?? '',
      jobTitle: employeeData['job_title'] != null ? employeeData['job_title']['name'] ?? '' : '',
      department: employeeData['department'] != null
          ? employeeData['department']['department_name'] ?? ''
          : '',
      branch: employeeData['branch'] != null ? employeeData['branch']['name'] ?? '' : '',
      isRecord: json['is_record'] ?? false,
      isCatch: json['is_catch'] ?? false,
    );
  }
}
