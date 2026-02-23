import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitFamily implements UseCase<void, SubmitFamilyParams> {
  final BiodataRepository repository;

  SubmitFamily(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitFamilyParams params) async {
    return await repository.submitFamily(params.toBody());
  }
}

class SubmitFamilyParams extends Equatable {
  final int employeeId;
  final String fatherName;
  final int fatherStatus;
  final int fatherAge;
  final String fatherLastEducation;
  final String fatherLastJobTitle;
  final String fatherLastJobCompany;
  final String motherName;
  final int motherStatus;
  final int motherAge;
  final String motherLastEducation;
  final String motherLastJobTitle;
  final String motherLastJobCompany;

  const SubmitFamilyParams({
    required this.employeeId,
    required this.fatherName,
    required this.fatherStatus,
    required this.fatherAge,
    required this.fatherLastEducation,
    required this.fatherLastJobTitle,
    required this.fatherLastJobCompany,
    required this.motherName,
    required this.motherStatus,
    required this.motherAge,
    required this.motherLastEducation,
    required this.motherLastJobTitle,
    required this.motherLastJobCompany,
  });

  Map<String, dynamic> toBody() {
    final body = <String, dynamic>{
      'employee_id': employeeId,
      'father_name': fatherName,
      'father_status': fatherStatus,
      'father_age': fatherAge,
      'father_last_education': fatherLastEducation,
      'mother_name': motherName,
      'mother_status': motherStatus,
      'mother_age': motherAge,
      'mother_last_education': motherLastEducation,
    };
    if (fatherLastJobTitle.isNotEmpty) {
      body['father_last_job_title'] = fatherLastJobTitle;
    }
    if (fatherLastJobCompany.isNotEmpty) {
      body['father_last_job_company'] = fatherLastJobCompany;
    }
    if (motherLastJobTitle.isNotEmpty) {
      body['mother_last_job_title'] = motherLastJobTitle;
    }
    if (motherLastJobCompany.isNotEmpty) {
      body['mother_last_job_company'] = motherLastJobCompany;
    }
    return body;
  }

  @override
  List<Object?> get props => [
    employeeId,
    fatherName,
    fatherStatus,
    fatherAge,
    fatherLastEducation,
    fatherLastJobTitle,
    fatherLastJobCompany,
    motherName,
    motherStatus,
    motherAge,
    motherLastEducation,
    motherLastJobTitle,
    motherLastJobCompany,
  ];
}
