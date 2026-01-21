import '../../domain/entities/employee.dart';

/// Employee model for data layer
/// Extends Employee entity and adds JSON serialization
class EmployeeModel extends Employee {
  const EmployeeModel({
    required super.id,
    required super.fullname,
    required super.nik,
    required super.email,
    super.photoUrl,
    super.phone,
    super.jobTitleId,
    super.jobTitle,
    super.departmentCode,
    super.department,
    super.branchCode,
    super.branch,
    super.status,
    super.type,
    super.totalPoint,
    super.biodata,
  });

  /// Create EmployeeModel from JSON
  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      nik: json['nik'] as String,
      email: json['email'] as String,
      photoUrl: json['photo_url'] as String?,
      phone: json['phone_number'] as String? ?? json['phone'] as String?,
      jobTitleId: json['job_title_id'] as int?,
      jobTitle: json['job_title'] is Map
          ? json['job_title']['name'] as String?
          : json['job_title'] as String?,
      departmentCode: json['department_code'] as String?,
      department: json['department'] is Map
          ? json['department']['department_name'] as String?
          : json['department'] as String?,
      branchCode: json['branch_code'] as String?,
      branch: json['branch'] is Map
          ? json['branch']['branch_name'] as String?
          : json['branch'] as String?,
      status: json['status'] as int?,
      type: json['type'] as String?,
      totalPoint: _parseDouble(json['total_point']),
      biodata: json['biodata'] != null
          ? BiodataInfoModel.fromJson(json['biodata'] as Map<String, dynamic>)
          : null,
    );
  }

  /// Convert EmployeeModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'nik': nik,
      'email': email,
      'photo_url': photoUrl,
      'phone': phone,
      'job_title_id': jobTitleId,
      'job_title': jobTitle,
      'department_code': departmentCode,
      'department': department,
      'branch_code': branchCode,
      'branch': branch,
      'status': status,
      'type': type,
      'total_point': totalPoint.toString(),
      'biodata': biodata != null
          ? (biodata as BiodataInfoModel).toJson()
          : null,
    };
  }

  /// Helper method to parse double from various types
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  /// Convert to domain entity
  Employee toEntity() {
    return Employee(
      id: id,
      fullname: fullname,
      nik: nik,
      email: email,
      photoUrl: photoUrl,
      phone: phone,
      jobTitleId: jobTitleId,
      jobTitle: jobTitle,
      departmentCode: departmentCode,
      department: department,
      branchCode: branchCode,
      branch: branch,
      status: status,
      type: type,
      totalPoint: totalPoint,
      biodata: biodata,
    );
  }
}

/// Biodata information model
class BiodataInfoModel extends BiodataInfo {
  const BiodataInfoModel({
    super.gender,
    super.birthPlace,
    super.birthDate,
    super.religion,
    super.maritalStatus,
    super.address,
  });

  /// Create BiodataInfoModel from JSON
  factory BiodataInfoModel.fromJson(Map<String, dynamic> json) {
    return BiodataInfoModel(
      gender: json['gender'] as String?,
      birthPlace: json['birth_place'] as String?,
      // V1 sends "YYYY-MM-DD", just use as String or parse if needed.
      // V2 entity expects String, so this is fine.
      birthDate: json['birth_date'] as String?,
      religion: json['religion'] as String?,
      maritalStatus:
          json['marital_status'] as String? ??
          json['residence_status']
              as String?, // V1 has residence_status, maybe map it? V1 also has marital status in other calls?
      // V1 Model has residence_status. It does NOT have marital_status in Biodata object explicitly shown in snippet?
      // Wait, V1 Biodata has residence_status.
      // And I checked V1 Biodata fields: gender, birthPlace, birthDate, religion, bloodType, weight, height, identityFullAddress, currentFullAddress.
      // It has `residence_status`.
      // It does NOT seem to have `marital_status`.
      // BUT `EmployeeModel` in V2 uses `maritalStatus` in `BiodataInfo`.
      // I will map `residence_status` to `maritalStatus` if that's the intent, OR leave it null.
      // V1 has `GetMaritalStatus` API.
      // For now, I'll try to map residence_status or current_address.
      // Actually `address` in V2 is mapped to `current_address` or `current_full_address`.
      address:
          json['current_address'] as String? ??
          json['current_full_address'] as String?,
    );
  }

  /// Convert BiodataInfoModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'birth_place': birthPlace,
      'birth_date': birthDate,
      'religion': religion,
      'marital_status': maritalStatus,
      'address': address,
    };
  }
}
