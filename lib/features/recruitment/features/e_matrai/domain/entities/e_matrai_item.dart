import 'package:equatable/equatable.dart';
import 'e_matrai_attachment.dart';
import 'e_matrai_employee.dart';

class EMatraiItem extends Equatable {
  final int id;
  final int employeeId;
  final String letterNumber;
  final String date;
  final String roleName;
  final String jobTitleName;
  final String departmentName;
  final String employeeStatus;
  final int countRevision;
  final int matraiStatus;
  final String matraiStatusDescription;
  final String revisionDescription;
  final String attachmentUrl;
  final EMatraiEmployee employee;
  final List<EMatraiAttachment> attachments;
  final String createdAt;
  final String updatedAt;

  const EMatraiItem({
    required this.id,
    required this.employeeId,
    required this.letterNumber,
    required this.date,
    required this.roleName,
    required this.jobTitleName,
    required this.departmentName,
    required this.employeeStatus,
    required this.countRevision,
    required this.matraiStatus,
    required this.matraiStatusDescription,
    required this.revisionDescription,
    required this.attachmentUrl,
    required this.employee,
    required this.attachments,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    letterNumber,
    date,
    roleName,
    jobTitleName,
    departmentName,
    employeeStatus,
    countRevision,
    matraiStatus,
    matraiStatusDescription,
    revisionDescription,
    attachmentUrl,
    employee,
    attachments,
    createdAt,
    updatedAt,
  ];
}
