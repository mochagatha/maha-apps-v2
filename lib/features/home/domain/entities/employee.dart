import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final int id;
  final String fullname;
  final String email;
  final int jobTitleId;
  final String jobTitleName;
  final int departmentId;
  final String departmentName;
  final String branchCode;
  final String branchName;
  final int status;
  final String? type;
  final Biodata? biodata;

  const Employee({
    required this.id,
    required this.fullname,
    required this.email,
    required this.jobTitleId,
    required this.jobTitleName,
    required this.departmentId,
    required this.departmentName,
    required this.branchCode,
    required this.branchName,
    required this.status,
    this.type,
    this.biodata,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        jobTitleId,
        jobTitleName,
        departmentId,
        departmentName,
        branchCode,
        branchName,
        status,
        type,
        biodata,
      ];
}

class Biodata extends Equatable {
  final String? gender;
  final String? phone;
  final String? address;
  final String? photoUrl;

  const Biodata({
    this.gender,
    this.phone,
    this.address,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [gender, phone, address, photoUrl];
}
