import 'package:equatable/equatable.dart';

class EMatraiEmployee extends Equatable {
  final int id;
  final String nik;
  final String fullname;
  final String photoUrl;
  final String signatureUrl;
  final String email;
  final String phoneNumber;
  final String departmentName;
  final String jobTitleName;

  const EMatraiEmployee({
    required this.id,
    required this.nik,
    required this.fullname,
    required this.photoUrl,
    required this.signatureUrl,
    required this.email,
    required this.phoneNumber,
    required this.departmentName,
    required this.jobTitleName,
  });

  @override
  List<Object?> get props => [
    id,
    nik,
    fullname,
    photoUrl,
    signatureUrl,
    email,
    phoneNumber,
    departmentName,
    jobTitleName,
  ];
}
