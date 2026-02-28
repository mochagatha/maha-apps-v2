import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maha_apps_v2/core/error/failures.dart';
import 'package:maha_apps_v2/core/usecases/usecase.dart';
import '../repositories/e_matrai_repository.dart';

class UploadMatrai implements UseCase<void, UploadMatraiParams> {
  final EMatraiRepository repository;

  UploadMatrai(this.repository);

  @override
  Future<Either<Failure, void>> call(UploadMatraiParams params) {
    return repository.uploadMatrai(
      employeeAgreementId: params.employeeAgreementId,
      filePath: params.filePath,
    );
  }
}

class UploadMatraiParams extends Equatable {
  final int employeeAgreementId;

  /// Absolute path to the PDF file on disk.
  final String filePath;

  const UploadMatraiParams({
    required this.employeeAgreementId,
    required this.filePath,
  });

  @override
  List<Object?> get props => [employeeAgreementId, filePath];
}
