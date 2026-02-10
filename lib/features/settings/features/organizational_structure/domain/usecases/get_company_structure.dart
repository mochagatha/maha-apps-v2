import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../entities/organizational_structure_entity.dart';
import '../repositories/organizational_structure_repository.dart';

class GetCompanyStructure {
  final OrganizationalStructureRepository repository;

  GetCompanyStructure(this.repository);

  Future<Either<Failure, List<OrganizationalStructureEntity>>> call(String typeStructure) async {
    return await repository.getCompanyStructure(typeStructure);
  }
}
