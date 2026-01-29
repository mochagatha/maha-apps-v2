import 'package:equatable/equatable.dart';

class JobTitleEntity extends Equatable {
  final int? id;
  final String? name;

  const JobTitleEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
