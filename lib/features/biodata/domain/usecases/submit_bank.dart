import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitBank implements UseCase<void, SubmitBankParams> {
  final BiodataRepository repository;

  SubmitBank(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitBankParams params) async {
    return await repository.submitBank(
      employeeId: params.employeeId,
      bankId: params.bankId,
      accountNumber: params.accountNumber,
      accountName: params.accountName,
    );
  }
}

class SubmitBankParams extends Equatable {
  final int employeeId;
  final int bankId;
  final String accountNumber;
  final String accountName;

  const SubmitBankParams({
    required this.employeeId,
    required this.bankId,
    required this.accountNumber,
    required this.accountName,
  });

  @override
  List<Object?> get props => [employeeId, bankId, accountNumber, accountName];
}
