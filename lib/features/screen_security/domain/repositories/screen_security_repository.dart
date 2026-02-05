import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/screen_security_entity.dart';

abstract class ScreenSecurityRepository {
  Future<Either<Failure, ScreenSecurityEntity>> getScreenSecuritySettings({
    required String type,
    required int employeeWorkerId,
  });
}
