import '../entities/employee.dart';

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
    return EmployeeModel(
      id: json['id'] ?? 0,
      fullname: json['fullname'] ?? '',
      email: json['email'] ?? '',
      jobTitleId: json['job_title_id'] ?? 0,
      jobTitleName: json['job_title_name'] ?? '',
      departmentId: json['department_id'] ?? 0,
      departmentName: json['department_name'] ?? '',
      branchCode: json['branch_code'] ?? '',
      branchName: json['branch_name'] ?? '',
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
      'biodata': biodata != null
          ? (biodata as BiodataModel).toJson()
          : null,
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
