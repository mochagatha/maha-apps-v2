import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitSignature implements UseCase<void, SubmitSignatureParams> {
  final BiodataRepository repository;

  SubmitSignature(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitSignatureParams params) async {
    return await repository.submitSignature(
      employeeId: params.employeeId,
      signaturePath: params.signaturePath,
    );
  }
}

class SubmitSignatureParams extends Equatable {
  final int employeeId;
  final String signaturePath;

  const SubmitSignatureParams({
    required this.employeeId,
    required this.signaturePath,
  });

  @override
  List<Object?> get props => [employeeId, signaturePath];
}
