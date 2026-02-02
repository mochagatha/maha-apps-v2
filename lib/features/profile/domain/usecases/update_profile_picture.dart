import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/profile_repository.dart';

/// Use case for updating profile picture
/// Uploads a new profile picture and returns the URL
class UpdateProfilePicture implements UseCase<String, UpdateProfilePictureParams> {
  final ProfileRepository repository;

  UpdateProfilePicture(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateProfilePictureParams params) async {
    return await repository.updateProfilePicture(params.image);
  }
}

/// Parameters for updating profile picture
class UpdateProfilePictureParams extends Equatable {
  final File image;

  const UpdateProfilePictureParams({required this.image});

  @override
  List<Object?> get props => [image];
}
