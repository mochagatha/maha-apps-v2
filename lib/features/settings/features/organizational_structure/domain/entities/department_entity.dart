import 'package:equatable/equatable.dart';

class DepartmentEntity extends Equatable {
  final int id;
  final String departmentCode;
  final String departmentName;

  const DepartmentEntity({
    required this.id,
    required this.departmentCode,
    required this.departmentName,
  });

  @override
  List<Object?> get props => [id, departmentCode, departmentName];
}
