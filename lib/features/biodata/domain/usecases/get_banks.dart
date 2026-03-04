import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bank.dart';
import '../repositories/biodata_repository.dart';

class GetBanks implements UseCase<List<Bank>, NoParams> {
  final BiodataRepository repository;

  GetBanks(this.repository);

  @override
  Future<Either<Failure, List<Bank>>> call(NoParams params) async {
    return await repository.getBanks();
  }
}
