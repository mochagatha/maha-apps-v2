import 'package:dartz/dartz.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/permission_repository.dart';

class PermissionRepositoryImpl implements PermissionRepository {
  @override
  Future<Either<Failure, bool>> checkPermissions() async {
    try {
      // Check required permissions: Camera and Location (mandatory)
      final cameraStatus = await Permission.camera.status;
      final locationStatus = await Permission.location.status;

      // Notification is optional (for Android 13+ only)
      // Don't block if notification permission is not granted
      if (cameraStatus.isGranted && (locationStatus.isGranted || locationStatus.isLimited)) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return const Left(PlatformFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isPermissionPermanentlyDenied() async {
    try {
      final cameraStatus = await Permission.camera.status;
      final locationStatus = await Permission.location.status;

      // Check if any MANDATORY permission is permanently denied
      // Notification is optional, so don't check it here
      final cameraPermanentlyDenied = cameraStatus.isPermanentlyDenied;
      final locationPermanentlyDenied = locationStatus.isPermanentlyDenied;

      return Right(cameraPermanentlyDenied || locationPermanentlyDenied);
    } catch (e) {
      return const Left(PlatformFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, bool>>> getDeniedPermissionsDetail() async {
    try {
      final cameraStatus = await Permission.camera.status;
      final locationStatus = await Permission.location.status;
      final notificationStatus = await Permission.notification.status;

      return Right({
        'camera': cameraStatus.isPermanentlyDenied,
        'location': locationStatus.isPermanentlyDenied,
        'notification': notificationStatus.isPermanentlyDenied,
      });
    } catch (e) {
      return const Left(PlatformFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> requestPermissions() async {
    try {
      // Check current status first
      final cameraStatus = await Permission.camera.status;
      final locationStatus = await Permission.location.status;

      // If permanently denied, can't request again - must open settings
      if (cameraStatus.isPermanentlyDenied || locationStatus.isPermanentlyDenied) {
        return const Right(false);
      }

      // Request Camera and Location permissions (mandatory)
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.location,
      ].request();

      final newCameraStatus = statuses[Permission.camera];
      final newLocationStatus = statuses[Permission.location];

      // Also try to request notification, but don't fail if it's not available
      try {
        await Permission.notification.request();
      } catch (e) {
        // Notification permission might not be available on older Android versions
        // Continue without blocking
      }

      if (newCameraStatus != null &&
          newCameraStatus.isGranted &&
          newLocationStatus != null &&
          (newLocationStatus.isGranted || newLocationStatus.isLimited)) {
        return const Right(true);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return const Left(PlatformFailure());
    }
  }

  @override
  Future<Either<Failure, void>> openSettings() async {
    try {
      await openAppSettings();
      return const Right(null);
    } catch (e) {
      return const Left(PlatformFailure());
    }
  }
}
