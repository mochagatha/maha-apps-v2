import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitEmployeeDocument implements UseCase<void, SubmitEmployeeDocumentParams> {
  final BiodataRepository repository;

  SubmitEmployeeDocument(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitEmployeeDocumentParams params) async {
    return await repository.submitEmployeeDocument(
      employeeId: params.employeeId,
      photoWithKtpPath: params.photoWithKtpPath,
    );
  }
}

class SubmitEmployeeDocumentParams extends Equatable {
  final int employeeId;
  final String photoWithKtpPath;

  const SubmitEmployeeDocumentParams({
    required this.employeeId,
    required this.photoWithKtpPath,
  });

  @override
  List<Object?> get props => [employeeId, photoWithKtpPath];
}
