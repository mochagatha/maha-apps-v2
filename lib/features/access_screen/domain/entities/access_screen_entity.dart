
import 'package:equatable/equatable.dart';

class AccessScreenGlobalEntity extends Equatable {
  final int id;
  final bool isRecord;
  final bool isCatch;

  const AccessScreenGlobalEntity({
    required this.id,
    required this.isRecord,
    required this.isCatch,
  });

  @override
  List<Object?> get props => [id, isRecord, isCatch];
}

class AccessScreenEmployeeEntity extends Equatable {
  final int id;
  final String fullname;
  final String nik;
  final String photoUrl;
  final String jobTitle;
  final String department;
  final String branch;
  final bool isRecord;
  final bool isCatch;

  const AccessScreenEmployeeEntity({
    required this.id,
    required this.fullname,
    required this.nik,
    required this.photoUrl,
    required this.jobTitle,
    required this.department,
    required this.branch,
    this.isRecord = false,
    this.isCatch = false,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        nik,
        photoUrl,
        jobTitle,
        department,
        branch,
        isRecord,
        isCatch,
      ];
}

class AccessScreenDetailEntity extends Equatable {
  final int id;
  final String fullname;
  final String nik;
  final String photoUrl;
  final String jobTitle;
  final String department;
  final String branch;
  final bool isRecord;
  final bool isCatch;

  const AccessScreenDetailEntity({
    required this.id,
    required this.fullname,
    required this.nik,
    required this.photoUrl,
    required this.jobTitle,
    required this.department,
    required this.branch,
    required this.isRecord,
    required this.isCatch,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        nik,
        photoUrl,
        jobTitle,
        department,
        branch,
        isRecord,
        isCatch,
      ];
}
