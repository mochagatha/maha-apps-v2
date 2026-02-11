import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageDepartment {
  final OrganizationalStructureRepository repository;

  ManageDepartment(this.repository);

  Future<Either<Failure, void>> addDepartment({
    required String name,
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.addDepartment(
      name: name,
      typeRole: typeRole,
      typeBranch: typeBranch,
    );
  }

  Future<Either<Failure, void>> updateDepartment({
    required int id,
    required String name,
  }) async {
    return await repository.updateDepartment(
      id: id,
      name: name,
    );
  }

  Future<Either<Failure, void>> deleteDepartment(int id) async {
    return await repository.deleteDepartment(id);
  }
}
