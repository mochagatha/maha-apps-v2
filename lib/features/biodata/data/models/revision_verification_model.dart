import '../../domain/entities/revision_verification.dart';

class RevisionItemModel extends RevisionItem {
  const RevisionItemModel({
    required super.id,
    required super.employeeVerificationDataId,
    required super.columnName,
  });

  factory RevisionItemModel.fromJson(Map<String, dynamic> json) {
    return RevisionItemModel(
      id: json['id'] as int,
      employeeVerificationDataId: json['employee_verification_data_id'] as int,
      columnName: json['column_name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employee_verification_data_id': employeeVerificationDataId,
      'column_name': columnName,
    };
  }
}

class RevisionVerificationModel extends RevisionVerification {
  const RevisionVerificationModel({
    required super.id,
    required super.employeeId,
    required super.status,
    required super.statusDescription,
    super.revisionDescription,
    required super.revision,
  });

  factory RevisionVerificationModel.fromJson(Map<String, dynamic> json) {
    final revisionList = (json['revision'] as List<dynamic>? ?? [])
        .map((item) => RevisionItemModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return RevisionVerificationModel(
      id: json['id'] as int,
      employeeId: json['employee_id'] as int,
      status: json['status'] as int? ?? 0,
      statusDescription: json['status_description'] as String? ?? '',
      revisionDescription: json['revision_description'] as String?,
      revision: revisionList,
    );
  }
}
