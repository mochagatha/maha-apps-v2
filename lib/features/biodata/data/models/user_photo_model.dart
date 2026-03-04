import 'package:dio/dio.dart';

import '../../domain/entities/user_photo.dart';

class UserPhotoModel extends UserPhoto {
  const UserPhotoModel({
    required super.userId,
    required super.userType,
    required super.faceAngle,
    required super.photoPath,
    required super.photoEmbedding,
  });

  factory UserPhotoModel.fromEntity(UserPhoto entity) => UserPhotoModel(
    userId: entity.userId,
    userType: entity.userType,
    faceAngle: entity.faceAngle,
    photoPath: entity.photoPath,
    photoEmbedding: entity.photoEmbedding,
  );

  /// Converts to multipart form-data for the /user-photo/create endpoint.
  /// Fields: user_id, user_type, face_angle, photo (File), photo_embedding.
  Future<FormData> toFormData() async {
    final embeddingString = photoEmbedding.map((v) => v.toStringAsFixed(10)).join(',');
    return FormData.fromMap({
      'user_id': userId,
      'user_type': userType,
      'face_angle': faceAngle,
      'photo': await MultipartFile.fromFile(
        photoPath,
        filename: 'selfie_$faceAngle.jpg',
      ),
      'photo_embedding': embeddingString,
    });
  }
}
