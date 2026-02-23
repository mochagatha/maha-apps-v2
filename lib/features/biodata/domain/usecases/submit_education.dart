import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitEducation implements UseCase<void, SubmitEducationParams> {
  final BiodataRepository repository;

  SubmitEducation(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitEducationParams params) async {
    return await repository.submitEducation(params.toBody());
  }
}

class SubmitEducationParams extends Equatable {
  final int employeeId;
  final String lastEducation;

  // Primary School (SD)
  final String primarySchool;
  final String psStartYear;
  final String psEndYear;

  // Junior High (SMP)
  final String juniorHighSchool;
  final String jhsStartYear;
  final String jhsEndYear;

  // Senior High (SMA)
  final String seniorHighSchool;
  final String shsStartYear;
  final String shsEndYear;

  // Bachelor (D I / D II / D III / S1)
  final String bachelorUniversity;
  final String bachelorMajor;
  final String bachelorStartYear;
  final String bachelorEndYear;
  final String bachelorGpa;
  final String bachelorDegree;

  // Master (S2)
  final String masterUniversity;
  final String masterMajor;
  final String masterStartYear;
  final String masterEndYear;
  final String masterGpa;
  final String masterDegree;

  // Doctoral (S3)
  final String doctoralUniversity;
  final String doctoralMajor;
  final String doctoralStartYear;
  final String doctoralEndYear;
  final String doctoralGpa;
  final String doctoralDegree;

  const SubmitEducationParams({
    required this.employeeId,
    required this.lastEducation,
    this.primarySchool = '',
    this.psStartYear = '',
    this.psEndYear = '',
    this.juniorHighSchool = '',
    this.jhsStartYear = '',
    this.jhsEndYear = '',
    this.seniorHighSchool = '',
    this.shsStartYear = '',
    this.shsEndYear = '',
    this.bachelorUniversity = '',
    this.bachelorMajor = '',
    this.bachelorStartYear = '',
    this.bachelorEndYear = '',
    this.bachelorGpa = '',
    this.bachelorDegree = '',
    this.masterUniversity = '',
    this.masterMajor = '',
    this.masterStartYear = '',
    this.masterEndYear = '',
    this.masterGpa = '',
    this.masterDegree = '',
    this.doctoralUniversity = '',
    this.doctoralMajor = '',
    this.doctoralStartYear = '',
    this.doctoralEndYear = '',
    this.doctoralGpa = '',
    this.doctoralDegree = '',
  });

  Map<String, dynamic> toBody() => {
    'employee_id': employeeId,
    'last_education': lastEducation,
    'senior_high_school': seniorHighSchool,
    'shs_start_year': int.tryParse(shsStartYear) ?? 0,
    'shs_end_year': int.tryParse(shsEndYear) ?? 0,
    'bachelor_university': bachelorUniversity,
    'bachelor_major': bachelorMajor,
    'bachelor_start_year': int.tryParse(bachelorStartYear) ?? 0,
    'bachelor_end_year': int.tryParse(bachelorEndYear) ?? 0,
    'bachelor_gpa': bachelorGpa,
    'bachelor_degree': bachelorDegree,
    'master_university': masterUniversity,
    'master_major': masterMajor,
    'master_start_year': int.tryParse(masterStartYear) ?? 0,
    'master_end_year': int.tryParse(masterEndYear) ?? 0,
    'master_gpa': masterGpa,
    'master_degree': masterDegree,
    'doctoral_university': doctoralUniversity,
    'doctoral_major': doctoralMajor,
    'doctoral_start_year': int.tryParse(doctoralStartYear) ?? 0,
    'doctoral_end_year': int.tryParse(doctoralEndYear) ?? 0,
    'doctoral_gpa': doctoralGpa,
    'doctoral_degree': doctoralDegree,
  };

  @override
  List<Object?> get props => [
    employeeId,
    lastEducation,
    primarySchool,
    psStartYear,
    psEndYear,
    juniorHighSchool,
    jhsStartYear,
    jhsEndYear,
    seniorHighSchool,
    shsStartYear,
    shsEndYear,
    bachelorUniversity,
    bachelorMajor,
    bachelorStartYear,
    bachelorEndYear,
    bachelorGpa,
    bachelorDegree,
    masterUniversity,
    masterMajor,
    masterStartYear,
    masterEndYear,
    masterGpa,
    masterDegree,
    doctoralUniversity,
    doctoralMajor,
    doctoralStartYear,
    doctoralEndYear,
    doctoralGpa,
    doctoralDegree,
  ];
}
