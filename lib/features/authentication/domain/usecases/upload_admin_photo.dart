import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// Use case for uploading admin photo with location data
class UploadAdminPhoto implements UseCase<void, UploadAdminPhotoParams> {
  final AuthRepository repository;

  UploadAdminPhoto(this.repository);

  @override
  Future<Either<Failure, void>> call(UploadAdminPhotoParams params) async {
    return await repository.uploadAdminPhoto(
      adminId: params.adminId,
      imagePath: params.imagePath,
      locationName: params.locationName,
      location: params.location,
    );
  }
}

/// Parameters for uploading admin photo
class UploadAdminPhotoParams extends Equatable {
  final int adminId;
  final String imagePath;
  final String locationName;
  final String location;

  const UploadAdminPhotoParams({
    required this.adminId,
    required this.imagePath,
    required this.locationName,
    required this.location,
  });

  @override
  List<Object?> get props => [adminId, imagePath, locationName, location];
}
