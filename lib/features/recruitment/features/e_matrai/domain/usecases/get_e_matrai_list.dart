import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:maha_apps_v2/core/error/failures.dart';
import 'package:maha_apps_v2/core/usecases/usecase.dart';
import '../entities/e_matrai_list.dart';
import '../repositories/e_matrai_repository.dart';

class GetEMatraiList implements UseCase<EMatraiList, GetEMatraiListParams> {
  final EMatraiRepository repository;

  GetEMatraiList(this.repository);

  @override
  Future<Either<Failure, EMatraiList>> call(GetEMatraiListParams params) {
    return repository.getEMatraiList(
      matraiStatus: params.matraiStatus,
      typeUser: params.typeUser,
    );
  }
}

class GetEMatraiListParams extends Equatable {
  final int matraiStatus;
  final String typeUser;

  const GetEMatraiListParams({
    required this.matraiStatus,
    required this.typeUser,
  });

  @override
  List<Object?> get props => [matraiStatus, typeUser];
}
