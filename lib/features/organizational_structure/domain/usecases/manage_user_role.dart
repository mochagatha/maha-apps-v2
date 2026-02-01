import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageUserRole {
  final OrganizationalStructureRepository repository;

  ManageUserRole(this.repository);

  Future<Either<Failure, void>> addUserRole({
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.addUserRole(
      name: name,
      supervisorRoleId: supervisorRoleId,
      typeRole: typeRole,
      typeBranch: typeBranch,
    );
  }

  Future<Either<Failure, void>> updateUserRole({
    required int id,
    required String name,
    int? supervisorRoleId,
    required String typeRole,
    required String typeBranch,
  }) async {
    return await repository.updateUserRole(
      id: id,
      name: name,
      supervisorRoleId: supervisorRoleId,
      typeRole: typeRole,
      typeBranch: typeBranch,
    );
  }

  Future<Either<Failure, void>> deleteUserRole(int id) async {
    return await repository.deleteUserRole(id);
  }
}
