import '../../domain/entities/employee.dart';

class EmployeeModel extends Employee {
  const EmployeeModel({
    required int id,
    required String fullname,
    required String email,
    required int jobTitleId,
    required String jobTitleName,
    required int departmentId,
    required String departmentName,
    required String branchCode,
    required String branchName,
    required int status,
    String? type,
    BiodataModel? biodata,
  }) : super(
         id: id,
         fullname: fullname,
         email: email,
         jobTitleId: jobTitleId,
         jobTitleName: jobTitleName,
         departmentId: departmentId,
         departmentName: departmentName,
         branchCode: branchCode,
         branchName: branchName,
         status: status,
         type: type,
         biodata: biodata,
       );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // Handle nested job_title object (V1 API structure) or flat job_title_name
    String jobTitleName = '';
    if (json['job_title'] != null && json['job_title'] is Map) {
      jobTitleName = json['job_title']['name'] ?? '';
    } else if (json['job_title_name'] != null) {
      jobTitleName = json['job_title_name'];
    }

    // Handle nested department object or flat department_name
    String departmentName = '';
    if (json['department'] != null && json['department'] is Map) {
      departmentName = json['department']['department_name'] ?? '';
    } else if (json['department_name'] != null) {
      departmentName = json['department_name'];
    }

    // Handle nested branch object or flat branch_name
    String branchName = '';
    if (json['branch'] != null && json['branch'] is Map) {
      branchName = json['branch']['branch_name'] ?? '';
    } else if (json['branch_name'] != null) {
      branchName = json['branch_name'];
    }

    return EmployeeModel(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      jobTitleId: json['job_title_id'] ?? 0,
      jobTitleName: jobTitleName,
      departmentId: json['department_id'] ?? 0,
      departmentName: departmentName,
      branchCode: json['branch_code'] ?? '',
      branchName: branchName,
      status: json['status'] ?? 0,
      type: json['type'],
      biodata: json['biodata'] != null
          ? BiodataModel.fromJson(json['biodata'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'job_title_id': jobTitleId,
      'job_title_name': jobTitleName,
      'department_id': departmentId,
      'department_name': departmentName,
      'branch_code': branchCode,
      'branch_name': branchName,
      'status': status,
      'type': type,
      'biodata': biodata != null ? (biodata as BiodataModel).toJson() : null,
    };
  }

  Employee toEntity() {
    return Employee(
      id: id,
      fullname: fullname,
      email: email,
      jobTitleId: jobTitleId,
      jobTitleName: jobTitleName,
      departmentId: departmentId,
      departmentName: departmentName,
      branchCode: branchCode,
      branchName: branchName,
      status: status,
      type: type,
      biodata: biodata,
    );
  }
}

class BiodataModel extends Biodata {
  const BiodataModel({
    String? gender,
    String? phone,
    String? address,
    String? photoUrl,
  }) : super(
         gender: gender,
         phone: phone,
         address: address,
         photoUrl: photoUrl,
       );

  factory BiodataModel.fromJson(Map<String, dynamic> json) {
    return BiodataModel(
      gender: json['gender'],
      phone: json['phone'],
      address: json['address'],
      photoUrl: json['photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'phone': phone,
      'address': address,
      'photo_url': photoUrl,
    };
  }
}
