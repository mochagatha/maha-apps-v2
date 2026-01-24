import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/biodata.dart';
import '../repositories/biodata_repository.dart';

class GetBiodata implements UseCase<Biodata, NoParams> {
  final BiodataRepository repository;

  GetBiodata(this.repository);

  @override
  Future<Either<Failure, Biodata>> call(NoParams params) async {
    return await repository.getBiodata();
  }
}
