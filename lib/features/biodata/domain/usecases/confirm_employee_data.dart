import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class ConfirmEmployeeData implements UseCase<void, ConfirmEmployeeDataParams> {
  final BiodataRepository repository;

  ConfirmEmployeeData(this.repository);

  @override
  Future<Either<Failure, void>> call(ConfirmEmployeeDataParams params) async {
    return await repository.confirmEmployeeData(
      employeeId: params.employeeId,
      confirmDate: params.confirmDate,
    );
  }
}

class ConfirmEmployeeDataParams extends Equatable {
  final int employeeId;
  final String confirmDate;

  const ConfirmEmployeeDataParams({
    required this.employeeId,
    required this.confirmDate,
  });

  @override
  List<Object?> get props => [employeeId, confirmDate];
}
