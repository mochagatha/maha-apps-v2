import '../../domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  const EmployeeModel({
    required super.id,
    required super.nik,
    required super.fullname,
    required super.photoUrl,
    super.jobTitleName,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'] as int? ?? 0,
      nik: json['nik'] as String? ?? '-',
      fullname: json['fullname'] as String? ?? 'Unknown',
      photoUrl: json['photo_url'] as String? ?? 'https://ui-avatars.com/api/?name=User',
      jobTitleName: json['job_title_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nik': nik,
      'fullname': fullname,
      'photo_url': photoUrl,
      'job_title_name': jobTitleName,
    };
  }

  EmployeeEntity toEntity() {
    return EmployeeEntity(
      id: id,
      nik: nik,
      fullname: fullname,
      photoUrl: photoUrl,
      jobTitleName: jobTitleName,
    );
  }
}
