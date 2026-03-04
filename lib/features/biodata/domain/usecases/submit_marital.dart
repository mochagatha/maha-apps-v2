import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitMarital implements UseCase<void, SubmitMaritalParams> {
  final BiodataRepository repository;

  SubmitMarital(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitMaritalParams params) async {
    return await repository.submitMarital(params.employeeId, params.toBody());
  }
}

class SubmitMaritalParams extends Equatable {
  final int employeeId;
  final String maritalStatus;
  final String? coupleName;
  final int? coupleAge;
  final String? coupleLastEducation;
  final String? coupleLastJobTitle;
  final String? coupleLastJobCompany;

  const SubmitMaritalParams({
    required this.employeeId,
    required this.maritalStatus,
    this.coupleName,
    this.coupleAge,
    this.coupleLastEducation,
    this.coupleLastJobTitle,
    this.coupleLastJobCompany,
  });

  Map<String, dynamic> toBody() {
    final body = <String, dynamic>{
      'marital_status': maritalStatus,
    };
    if (coupleName != null && coupleName!.isNotEmpty) {
      body['couple_name'] = coupleName;
    }
    if (coupleAge != null) {
      body['couple_age'] = coupleAge;
    }
    if (coupleLastEducation != null && coupleLastEducation!.isNotEmpty) {
      body['couple_last_education'] = coupleLastEducation;
    }
    if (coupleLastJobTitle != null && coupleLastJobTitle!.isNotEmpty) {
      body['couple_last_job_title'] = coupleLastJobTitle;
    }
    if (coupleLastJobCompany != null && coupleLastJobCompany!.isNotEmpty) {
      body['couple_last_job_company'] = coupleLastJobCompany;
    }
    return body;
  }

  @override
  List<Object?> get props => [
    employeeId,
    maritalStatus,
    coupleName,
    coupleAge,
    coupleLastEducation,
    coupleLastJobTitle,
    coupleLastJobCompany,
  ];
}
