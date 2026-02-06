
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/access_screen_entity.dart';

abstract class AccessScreenRepository {
  Future<Either<Failure, AccessScreenGlobalEntity>> getAccessScreenList(String type);
  Future<Either<Failure, AccessScreenDetailEntity>> getAccessScreenDetail(String type, int id);
  Future<Either<Failure, void>> updateGlobalAccessScreen(int id, bool isRecord, bool isCatch);
  Future<Either<Failure, void>> updateDetailAccessScreen(int id, bool isRecord, bool isCatch);
}
