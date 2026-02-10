import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageEmploymentLevel {
  final OrganizationalStructureRepository repository;

  ManageEmploymentLevel(this.repository);

  Future<Either<Failure, void>> addEmploymentLevel({
    required String name,
    required String typeRole,
  }) async {
    return await repository.addEmploymentLevel(
      name: name,
      typeRole: typeRole,
    );
  }

  Future<Either<Failure, void>> updateEmploymentLevel({
    required int id,
    required String name,
  }) async {
    return await repository.updateEmploymentLevel(
      id: id,
      name: name,
    );
  }

  Future<Either<Failure, void>> deleteEmploymentLevel(int id) async {
    return await repository.deleteEmploymentLevel(id);
  }
}
