
import 'package:dartz/dartz.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repositories/access_screen_repository.dart';

class UpdateGlobalAccessScreen implements UseCase<void, UpdateGlobalAccessScreenParams> {
  final AccessScreenRepository repository;

  UpdateGlobalAccessScreen(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateGlobalAccessScreenParams params) async {
    return await repository.updateGlobalAccessScreen(params.id, params.isRecord, params.isCatch);
  }
}

class UpdateGlobalAccessScreenParams {
  final int id;
  final bool isRecord;
  final bool isCatch;

  UpdateGlobalAccessScreenParams({
    required this.id,
    required this.isRecord,
    required this.isCatch,
  });
}

class UpdateDetailAccessScreen implements UseCase<void, UpdateDetailAccessScreenParams> {
  final AccessScreenRepository repository;

  UpdateDetailAccessScreen(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateDetailAccessScreenParams params) async {
    return await repository.updateDetailAccessScreen(params.id, params.isRecord, params.isCatch);
  }
}

class UpdateDetailAccessScreenParams {
  final int id;
  final bool isRecord;
  final bool isCatch;

  UpdateDetailAccessScreenParams({
    required this.id,
    required this.isRecord,
    required this.isCatch,
  });
}
