import 'package:equatable/equatable.dart';

class RevisionItem extends Equatable {
  final int id;
  final int employeeVerificationDataId;
  final String columnName;

  const RevisionItem({
    required this.id,
    required this.employeeVerificationDataId,
    required this.columnName,
  });

  @override
  List<Object?> get props => [id, employeeVerificationDataId, columnName];
}

class RevisionVerification extends Equatable {
  final int id;
  final int employeeId;
  final int status;
  final String statusDescription;
  final String? revisionDescription;
  final List<RevisionItem> revision;

  const RevisionVerification({
    required this.id,
    required this.employeeId,
    required this.status,
    required this.statusDescription,
    this.revisionDescription,
    required this.revision,
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    status,
    statusDescription,
    revisionDescription,
    revision,
  ];
}
