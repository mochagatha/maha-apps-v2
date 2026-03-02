import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_photo.dart';
import '../repositories/biodata_repository.dart';

class SubmitUserPhoto implements UseCase<void, SubmitUserPhotoParams> {
  final BiodataRepository repository;

  SubmitUserPhoto(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitUserPhotoParams params) async {
    return await repository.submitUserPhoto(params.userPhoto);
  }
}

class SubmitUserPhotoParams extends Equatable {
  final UserPhoto userPhoto;

  const SubmitUserPhotoParams({required this.userPhoto});

  @override
  List<Object?> get props => [userPhoto];
}
