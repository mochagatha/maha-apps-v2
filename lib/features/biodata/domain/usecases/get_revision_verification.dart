import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/revision_verification.dart';
import '../repositories/biodata_repository.dart';

class GetRevisionVerification
    implements UseCase<RevisionVerification, GetRevisionVerificationParams> {
  final BiodataRepository repository;

  GetRevisionVerification(this.repository);

  @override
  Future<Either<Failure, RevisionVerification>> call(GetRevisionVerificationParams params) async {
    return await repository.getRevisionVerification(params.employeeId);
  }
}

class GetRevisionVerificationParams extends Equatable {
  final int employeeId;

  const GetRevisionVerificationParams({required this.employeeId});

  @override
  List<Object?> get props => [employeeId];
}
