import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

abstract class PermissionRepository {
  Future<Either<Failure, bool>> checkPermissions();
  Future<Either<Failure, bool>> requestPermissions();
  Future<Either<Failure, void>> openSettings();
  Future<Either<Failure, bool>> isPermissionPermanentlyDenied();
  Future<Either<Failure, Map<String, bool>>> getDeniedPermissionsDetail();
}
