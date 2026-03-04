import 'package:equatable/equatable.dart';

/// Represents a single angle photo submission for face embedding registration.
/// Three instances are created per user: front, right, left.
class UserPhoto extends Equatable {
  final int userId;
  final String userType;
  final String faceAngle; // 'front' | 'right' | 'left'
  final String photoPath;
  final List<double> photoEmbedding;

  const UserPhoto({
    required this.userId,
    required this.userType,
    required this.faceAngle,
    required this.photoPath,
    required this.photoEmbedding,
  });

  @override
  List<Object?> get props => [userId, userType, faceAngle, photoPath, photoEmbedding];
}
