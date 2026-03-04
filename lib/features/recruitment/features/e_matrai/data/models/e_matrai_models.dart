import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_attachment.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_employee.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_item.dart';
import 'package:maha_apps_v2/features/recruitment/features/e_matrai/domain/entities/e_matrai_list.dart';

// ---------------------------------------------------------------------------
// EMatraiAttachmentModel
// ---------------------------------------------------------------------------
class EMatraiAttachmentModel extends EMatraiAttachment {
  const EMatraiAttachmentModel({
    required super.id,
    required super.employeeAgreementId,
    required super.attachment,
    required super.attachmentUrl,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EMatraiAttachmentModel.fromJson(Map<String, dynamic> json) {
    return EMatraiAttachmentModel(
      id: json['id'] as int? ?? 0,
      employeeAgreementId: json['employee_agreement_id'] as int? ?? 0,
      attachment: json['attachment'] as String? ?? '',
      attachmentUrl: json['attachment_url'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}

// ---------------------------------------------------------------------------
// EMatraiEmployeeModel
// ---------------------------------------------------------------------------
class EMatraiEmployeeModel extends EMatraiEmployee {
  const EMatraiEmployeeModel({
    required super.id,
    required super.nik,
    required super.fullname,
    required super.photoUrl,
    required super.signatureUrl,
    required super.email,
    required super.phoneNumber,
    required super.departmentName,
    required super.jobTitleName,
  });

  factory EMatraiEmployeeModel.fromJson(Map<String, dynamic> json) {
    // department name can be nested object or flat
    final dept = json['department'];
    final String deptName =
        (dept is Map<String, dynamic> ? dept['department_name'] as String? : null) ??
        json['department_name'] as String? ??
        '';

    // job_title name
    final jt = json['job_title'];
    final String jtName =
        (jt is Map<String, dynamic> ? jt['name'] as String? : null) ??
        json['job_title_name'] as String? ??
        '';

    return EMatraiEmployeeModel(
      id: json['id'] as int? ?? 0,
      nik: json['nik'] as String? ?? '',
      fullname: json['fullname'] as String? ?? '',
      photoUrl: json['photo_url'] as String? ?? '',
      signatureUrl: json['signature_url'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      departmentName: deptName,
      jobTitleName: jtName,
    );
  }
}

// ---------------------------------------------------------------------------
// EMatraiItemModel
// ---------------------------------------------------------------------------
class EMatraiItemModel extends EMatraiItem {
  const EMatraiItemModel({
    required super.id,
    required super.employeeId,
    required super.letterNumber,
    required super.date,
    required super.roleName,
    required super.jobTitleName,
    required super.departmentName,
    required super.employeeStatus,
    required super.countRevision,
    required super.matraiStatus,
    required super.matraiStatusDescription,
    required super.revisionDescription,
    required super.attachmentUrl,
    required super.employee,
    required super.attachments,
    required super.createdAt,
    required super.updatedAt,
  });

  factory EMatraiItemModel.fromJson(Map<String, dynamic> json) {
    final employeeJson = json['employee'] as Map<String, dynamic>?;
    final attachmentList = json['attachment'] as List<dynamic>? ?? [];

    return EMatraiItemModel(
      id: json['id'] as int? ?? 0,
      employeeId: json['employee_id'] as int? ?? 0,
      letterNumber: json['letter_number'] as String? ?? '',
      date: json['date'] as String? ?? '',
      roleName: json['role_name'] as String? ?? '',
      jobTitleName: json['job_title_name'] as String? ?? '',
      departmentName: json['department_name'] as String? ?? '',
      employeeStatus: json['employee_status'] as String? ?? '',
      countRevision: json['count_revision'] as int? ?? 0,
      matraiStatus: json['matrai_status'] as int? ?? 0,
      matraiStatusDescription: json['matrai_status_description'] as String? ?? '',
      revisionDescription: json['revision_description'] as String? ?? '',
      attachmentUrl: json['attachment_url'] as String? ?? '',
      employee: employeeJson != null
          ? EMatraiEmployeeModel.fromJson(employeeJson)
          : const EMatraiEmployeeModel(
              id: 0,
              nik: '',
              fullname: '',
              photoUrl: '',
              signatureUrl: '',
              email: '',
              phoneNumber: '',
              departmentName: '',
              jobTitleName: '',
            ),
      attachments: attachmentList
          .map((e) => EMatraiAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }
}

// ---------------------------------------------------------------------------
// EMatraiCountModel
// ---------------------------------------------------------------------------
class EMatraiCountModel extends EMatraiCount {
  const EMatraiCountModel({
    required super.all,
    required super.approve,
    required super.newCount,
    required super.upload,
  });

  factory EMatraiCountModel.fromJson(Map<String, dynamic> json) {
    return EMatraiCountModel(
      all: json['all'] as int? ?? 0,
      approve: json['approve'] as int? ?? 0,
      newCount: json['new'] as int? ?? 0,
      upload: json['upload'] as int? ?? 0,
    );
  }
}

// ---------------------------------------------------------------------------
// EMatraiListModel
// ---------------------------------------------------------------------------
class EMatraiListModel extends EMatraiList {
  const EMatraiListModel({
    required super.count,
    required super.items,
  });

  factory EMatraiListModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final countJson = data['count'] as Map<String, dynamic>? ?? {};
    final itemList = data['data'] as List<dynamic>? ?? [];

    return EMatraiListModel(
      count: EMatraiCountModel.fromJson(countJson),
      items: itemList.map((e) => EMatraiItemModel.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}
