import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitVerificationData implements UseCase<void, SubmitVerificationDataParams> {
  final BiodataRepository repository;

  SubmitVerificationData(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitVerificationDataParams params) async {
    return await repository.submitVerificationData(
      employeeId: params.employeeId,
      status: params.status,
    );
  }
}

class SubmitVerificationDataParams extends Equatable {
  final int employeeId;
  final int status;

  const SubmitVerificationDataParams({
    required this.employeeId,
    required this.status,
  });

  @override
  List<Object?> get props => [employeeId, status];
}
