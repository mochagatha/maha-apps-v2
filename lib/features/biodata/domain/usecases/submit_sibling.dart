import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitSibling implements UseCase<void, SubmitSiblingParams> {
  final BiodataRepository repository;

  SubmitSibling(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitSiblingParams params) async {
    return await repository.submitSibling(params.toBody());
  }
}

class SubmitSiblingParams extends Equatable {
  final int employeeId;
  final String siblingName;
  final String siblingGender;
  final int siblingStatus;
  final int siblingAge;
  final String siblingLastEducation;
  final String siblingLastJobTitle;
  final String siblingLastJobCompany;

  const SubmitSiblingParams({
    required this.employeeId,
    required this.siblingName,
    required this.siblingGender,
    this.siblingStatus = 1,
    required this.siblingAge,
    required this.siblingLastEducation,
    required this.siblingLastJobTitle,
    required this.siblingLastJobCompany,
  });

  Map<String, dynamic> toBody() {
    final body = <String, dynamic>{
      'employee_id': employeeId,
      'sibling_name': siblingName,
      'sibling_gender': siblingGender,
      'sibling_status': siblingStatus,
      'sibling_age': siblingAge,
      'sibling_last_education': siblingLastEducation,
      'sibling_last_job_title': siblingLastJobTitle,
      'sibling_last_job_company': siblingLastJobCompany,
    };
    return body;
  }

  @override
  List<Object?> get props => [
    employeeId,
    siblingName,
    siblingGender,
    siblingStatus,
    siblingAge,
    siblingLastEducation,
    siblingLastJobTitle,
    siblingLastJobCompany,
  ];
}
