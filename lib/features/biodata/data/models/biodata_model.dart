import '../../domain/entities/biodata.dart';

class BiodataModel extends Biodata {
  const BiodataModel({
    required super.id,
    required super.fullname,
    required super.email,
    super.nik,
    super.photoUrl,
    super.jobTitle,
    super.department,
    super.branch,
    super.totalPoint,
  });

  factory BiodataModel.fromJson(Map<String, dynamic> json) {
    return BiodataModel(
      id: json['id'] as int,
      fullname: json['fullname'] as String,
      email: json['email'] as String,
      nik: json['nik'] as String?,
      photoUrl: json['photo_url'] as String?,
      jobTitle: json['job_title'] is Map
          ? json['job_title']['name'] as String?
          : json['job_title'] as String?,
      department: json['department'] is Map
          ? json['department']['department_name'] as String?
          : json['department'] as String?,
      branch: json['branch'] is Map
          ? json['branch']['branch_name'] as String?
          : json['branch'] as String?,
      totalPoint: _parseDouble(json['total_point']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'nik': nik,
      'photo_url': photoUrl,
      'job_title': jobTitle,
      'department': department,
      'branch': branch,
      'total_point': totalPoint,
    };
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
