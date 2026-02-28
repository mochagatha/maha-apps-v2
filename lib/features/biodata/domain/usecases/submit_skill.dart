import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitSkill implements UseCase<void, SubmitSkillParams> {
  final BiodataRepository repository;

  SubmitSkill(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitSkillParams params) async {
    return await repository.submitSkill(
      employeeId: params.employeeId,
      skills: params.skills,
    );
  }
}

class SubmitSkillParams extends Equatable {
  final int employeeId;
  final List<String> skills;

  const SubmitSkillParams({
    required this.employeeId,
    required this.skills,
  });

  @override
  List<Object?> get props => [employeeId, skills];
}
