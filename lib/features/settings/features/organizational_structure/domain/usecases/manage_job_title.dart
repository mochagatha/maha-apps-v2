import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageJobTitle {
  final OrganizationalStructureRepository repository;

  ManageJobTitle(this.repository);

  Future<Either<Failure, void>> addJobTitle({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.addJobTitle(
      name: name,
      typeRole: typeRole,
      typeBranch: typeBranch,
    );
  }

  Future<Either<Failure, void>> updateJobTitle({
    required int id,
    required String name,
  }) async {
    return await repository.updateJobTitle(
      id: id,
      name: name,
    );
  }

  Future<Either<Failure, void>> deleteJobTitle(int id) async {
    return await repository.deleteJobTitle(id);
  }
}
