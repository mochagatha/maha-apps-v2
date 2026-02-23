import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitChildren implements UseCase<void, SubmitChildrenParams> {
  final BiodataRepository repository;

  SubmitChildren(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitChildrenParams params) async {
    return await repository.submitChildren(params.toBody());
  }
}

class SubmitChildrenParams extends Equatable {
  final int employeeId;
  final String childName;
  final String childGender;
  final int childAge;
  final int childStatus;
  final String childLastEducation;
  final String childLastJobTitle;
  final String childLastJobCompany;

  const SubmitChildrenParams({
    required this.employeeId,
    required this.childName,
    required this.childGender,
    required this.childAge,
    this.childStatus = 1,
    required this.childLastEducation,
    required this.childLastJobTitle,
    required this.childLastJobCompany,
  });

  Map<String, dynamic> toBody() {
    return {
      'employee_id': employeeId,
      'child_name': childName,
      'child_gender': childGender,
      'child_age': childAge,
      'child_status': childStatus,
      'child_last_education': childLastEducation,
      'child_last_job_title': childLastJobTitle,
      'child_last_job_company': childLastJobCompany,
    };
  }

  @override
  List<Object?> get props => [
    employeeId,
    childName,
    childGender,
    childAge,
    childStatus,
    childLastEducation,
    childLastJobTitle,
    childLastJobCompany,
  ];
}
