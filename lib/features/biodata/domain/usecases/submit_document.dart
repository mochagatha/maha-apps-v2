import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitDocument implements UseCase<void, SubmitDocumentParams> {
  final BiodataRepository repository;

  SubmitDocument(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitDocumentParams params) async {
    return await repository.submitDocument(
      employeeId: params.employeeId,
      photoPath: params.photoPath,
      ktpPath: params.ktpPath,
      kkPath: params.kkPath,
      certificatePath: params.certificatePath,
      gradeTranscriptPath: params.gradeTranscriptPath,
      certificateSkillPath: params.certificateSkillPath,
      bankAccountPath: params.bankAccountPath,
      npwpPath: params.npwpPath,
      bpjsKtnPath: params.bpjsKtnPath,
      bpjsKesPath: params.bpjsKesPath,
    );
  }
}

class SubmitDocumentParams extends Equatable {
  final int employeeId;
  final String photoPath;
  final String ktpPath;
  final String kkPath;
  final String certificatePath;
  final String gradeTranscriptPath;
  final String? certificateSkillPath;
  final String? bankAccountPath;
  final String? npwpPath;
  final String? bpjsKtnPath;
  final String? bpjsKesPath;

  const SubmitDocumentParams({
    required this.employeeId,
    required this.photoPath,
    required this.ktpPath,
    required this.kkPath,
    required this.certificatePath,
    required this.gradeTranscriptPath,
    this.certificateSkillPath,
    this.bankAccountPath,
    this.npwpPath,
    this.bpjsKtnPath,
    this.bpjsKesPath,
  });

  @override
  List<Object?> get props => [
    employeeId,
    photoPath,
    ktpPath,
    kkPath,
    certificatePath,
    gradeTranscriptPath,
    certificateSkillPath,
    bankAccountPath,
    npwpPath,
    bpjsKtnPath,
    bpjsKesPath,
  ];
}
