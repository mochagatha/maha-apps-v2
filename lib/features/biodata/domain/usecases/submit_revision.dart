import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitRevision implements UseCase<void, SubmitRevisionParams> {
  final BiodataRepository repository;

  SubmitRevision(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitRevisionParams params) async {
    return await repository.submitRevision(
      employeeId: params.employeeId,
      body: params.body,
    );
  }
}

class SubmitRevisionParams extends Equatable {
  final int employeeId;
  final Map<String, dynamic> body;

  const SubmitRevisionParams({
    required this.employeeId,
    required this.body,
  });

  @override
  List<Object?> get props => [employeeId, body];
}
