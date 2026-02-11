import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../repositories/organizational_structure_repository.dart';

class ManageStructureRole {
  final OrganizationalStructureRepository repository;

  ManageStructureRole(this.repository);

  Future<Either<Failure, void>> createRole({
    required int companyStructureId,
    required List<int> userRoleIds,
  }) async {
    return await repository.createCompanyStructureRole(
      companyStructureId: companyStructureId,
      userRoleIds: userRoleIds,
    );
  }

  Future<Either<Failure, void>> deleteRole(int id) async {
    return await repository.deleteCompanyStructureRole(id);
  }
}
