import 'package:equatable/equatable.dart';

/// Employee entity representing the complete employee profile
/// This is an extended version that includes all profile-related data
class Employee extends Equatable {
  final int id;
  final String fullname;
  final String nik;
  final String email;
  final String? photoUrl;
  final String? phone;
  final int? jobTitleId;
  final String? jobTitle;
  final String? departmentCode;
  final String? department;
  final String? branchCode;
  final String? branch;
  final int? status;
  final String? type;
  final double totalPoint;
  final BiodataInfo? biodata;

  const Employee({
    required this.id,
    required this.fullname,
    required this.nik,
    required this.email,
    this.photoUrl,
    this.phone,
    this.jobTitleId,
    this.jobTitle,
    this.departmentCode,
    this.department,
    this.branchCode,
    this.branch,
    this.status,
    this.type,
    this.totalPoint = 0.0,
    this.biodata,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        nik,
        email,
        photoUrl,
        phone,
        jobTitleId,
        jobTitle,
        departmentCode,
        department,
        branchCode,
        branch,
        status,
        type,
        totalPoint,
        biodata,
      ];
}

/// Biodata information entity
class BiodataInfo extends Equatable {
  final String? gender;
  final String? birthPlace;
  final String? birthDate;
  final String? religion;
  final String? maritalStatus;
  final String? address;

  const BiodataInfo({
    this.gender,
    this.birthPlace,
    this.birthDate,
    this.religion,
    this.maritalStatus,
    this.address,
  });

  @override
  List<Object?> get props => [
        gender,
        birthPlace,
        birthDate,
        religion,
        maritalStatus,
        address,
      ];
}
