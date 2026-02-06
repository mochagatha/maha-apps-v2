
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/access_screen_entity.dart';
import '../repositories/access_screen_repository.dart';

class GetAccessScreenList implements UseCase<AccessScreenGlobalEntity, String> {
  final AccessScreenRepository repository;

  GetAccessScreenList(this.repository);

  @override
  Future<Either<Failure, AccessScreenGlobalEntity>> call(String params) async {
    return await repository.getAccessScreenList(params);
  }
}

class GetAccessScreenDetail implements UseCase<AccessScreenDetailEntity, GetAccessScreenDetailParams> {
  final AccessScreenRepository repository;

  GetAccessScreenDetail(this.repository);

  @override
  Future<Either<Failure, AccessScreenDetailEntity>> call(GetAccessScreenDetailParams params) async {
    return await repository.getAccessScreenDetail(params.type, params.id);
  }
}

class GetAccessScreenDetailParams {
  final String type;
  final int id;

  GetAccessScreenDetailParams({required this.type, required this.id});
}
