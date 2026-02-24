import 'package:equatable/equatable.dart';

class EMatraiAttachment extends Equatable {
  final int id;
  final int employeeAgreementId;
  final String attachment;
  final String attachmentUrl;
  final String createdAt;
  final String updatedAt;

  const EMatraiAttachment({
    required this.id,
    required this.employeeAgreementId,
    required this.attachment,
    required this.attachmentUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    employeeAgreementId,
    attachment,
    attachmentUrl,
    createdAt,
    updatedAt,
  ];
}
