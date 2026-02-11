import 'package:equatable/equatable.dart';

class EmploymentLevelEntity extends Equatable {
  final int id;
  final String name;
  final String typeRole;

  const EmploymentLevelEntity({
    required this.id,
    required this.name,
    required this.typeRole,
  });

  @override
  List<Object?> get props => [id, name, typeRole];
}
