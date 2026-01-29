import 'package:equatable/equatable.dart';

class EmployeeEntity extends Equatable {
  final int id;
  final String nik;
  final String fullname;
  final String photoUrl;
  final String? jobTitleName;

  const EmployeeEntity({
    required this.id,
    required this.nik,
    required this.fullname,
    required this.photoUrl,
    this.jobTitleName,
  });

  @override
  List<Object?> get props => [id, nik, fullname, photoUrl, jobTitleName];
}
