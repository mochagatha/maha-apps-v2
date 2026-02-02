import 'package:equatable/equatable.dart';

class Biodata extends Equatable {
  final int id;
  final String fullname;
  final String email;
  final String? nik;
  final String? photoUrl;
  final String? jobTitle;
  final String? department;
  final String? branch;
  final double totalPoint;

  const Biodata({
    required this.id,
    required this.fullname,
    required this.email,
    this.nik,
    this.photoUrl,
    this.jobTitle,
    this.department,
    this.branch,
    this.totalPoint = 0.0,
  });

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        nik,
        photoUrl,
        jobTitle,
        department,
        branch,
        totalPoint,
      ];
}
