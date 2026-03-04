import '../../domain/entities/employee_full_data.dart';

class BiodataInfoModel extends BiodataInfo {
  const BiodataInfoModel({
    required super.id,
    required super.employeeId,
    required super.fullname,
    super.nickname,
    super.nik,
    super.identityProvince,
    super.identityRegency,
    super.identityDistrict,
    super.identityVillage,
    super.identityPostalCode,
    super.identityAddress,
    super.currentProvince,
    super.currentRegency,
    super.currentDistrict,
    super.currentVillage,
    super.currentPostalCode,
    super.currentAddress,
    super.residenceStatus,
    super.phoneNumber,
    super.emergencyPhoneNumber,
    super.gender,
    super.birthPlace,
    super.birthDate,
    super.religion,
    super.bloodType,
    super.weight,
    super.height,
  });

  factory BiodataInfoModel.fromJson(Map<String, dynamic> json) {
    return BiodataInfoModel(
      id: json['id'] as int? ?? 0,
      employeeId: json['employee_id'] as int? ?? 0,
      fullname: json['fullname'] as String? ?? '',
      nickname: json['nickname'] as String?,
      nik: json['nik'] as String?,
      identityProvince: _parseInt(json['identity_province']),
      identityRegency: _parseInt(json['identity_regency']),
      identityDistrict: _parseInt(json['identity_district']),
      identityVillage: _parseInt(json['identity_village']),
      identityPostalCode: _parseInt(json['identity_postal_code']),
      identityAddress: json['identity_address'] as String?,
      currentProvince: _parseInt(json['current_province']),
      currentRegency: _parseInt(json['current_regency']),
      currentDistrict: _parseInt(json['current_district']),
      currentVillage: _parseInt(json['current_village']),
      currentPostalCode: _parseInt(json['current_postal_code']),
      currentAddress: json['current_address'] as String?,
      residenceStatus: json['residence_status'] as String?,
      phoneNumber: json['phone_number'] as String?,
      emergencyPhoneNumber: json['emergency_phone_number'] as String?,
      gender: json['gender'] as String?,
      birthPlace: json['birth_place'] as String?,
      birthDate: json['birth_date'] as String?,
      religion: json['religion'] as String?,
      bloodType: json['blood_type'] as String?,
      weight: _parseInt(json['weight']),
      height: _parseInt(json['height']),
    );
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class EducationInfoModel extends EducationInfo {
  const EducationInfoModel({
    super.lastEducation,
    super.primarySchool,
    super.psStartYear,
    super.psEndYear,
    super.juniorHighSchool,
    super.jhsStartYear,
    super.jhsEndYear,
    super.seniorHighSchool,
    super.shsStartYear,
    super.shsEndYear,
    super.shsGpa,
    super.bachelorUniversity,
    super.bachelorMajor,
    super.bachelorStartYear,
    super.bachelorEndYear,
    super.bachelorGpa,
    super.bachelorDegree,
    super.masterUniversity,
    super.masterMajor,
    super.masterStartYear,
    super.masterEndYear,
    super.masterGpa,
    super.masterDegree,
    super.doctoralUniversity,
    super.doctoralMajor,
    super.doctoralStartYear,
    super.doctoralEndYear,
    super.doctoralGpa,
    super.doctoralDegree,
    super.lastEducationMajor,
  });

  factory EducationInfoModel.fromJson(Map<String, dynamic> json) {
    return EducationInfoModel(
      lastEducation: json['last_education'] as String?,
      primarySchool: json['primary_school'] as String?,
      psStartYear: json['ps_start_year']?.toString(),
      psEndYear: json['ps_end_year']?.toString(),
      juniorHighSchool: json['junior_high_school'] as String?,
      jhsStartYear: json['jhs_start_year']?.toString(),
      jhsEndYear: json['jhs_end_year']?.toString(),
      seniorHighSchool: json['senior_high_school'] as String?,
      shsStartYear: json['shs_start_year']?.toString(),
      shsEndYear: json['shs_end_year']?.toString(),
      shsGpa: json['shs_gpa']?.toString(),
      bachelorUniversity: json['bachelor_university'] as String?,
      bachelorMajor: json['bachelor_major'] as String?,
      bachelorStartYear: json['bachelor_start_year']?.toString(),
      bachelorEndYear: json['bachelor_end_year']?.toString(),
      bachelorGpa: json['bachelor_gpa']?.toString(),
      bachelorDegree: json['bachelor_degree'] as String?,
      masterUniversity: json['master_university'] as String?,
      masterMajor: json['master_major'] as String?,
      masterStartYear: json['master_start_year']?.toString(),
      masterEndYear: json['master_end_year']?.toString(),
      masterGpa: json['master_gpa']?.toString(),
      masterDegree: json['master_degree'] as String?,
      doctoralUniversity: json['doctoral_university'] as String?,
      doctoralMajor: json['doctoral_major'] as String?,
      doctoralStartYear: json['doctoral_start_year']?.toString(),
      doctoralEndYear: json['doctoral_end_year']?.toString(),
      doctoralGpa: json['doctoral_gpa']?.toString(),
      doctoralDegree: json['doctoral_degree'] as String?,
      lastEducationMajor: json['last_education_major'] as String?,
    );
  }
}

class FamilyInfoModel extends FamilyInfo {
  const FamilyInfoModel({
    super.fatherName,
    super.fatherStatus,
    super.fatherAge,
    super.fatherLastEducation,
    super.fatherLastJobTitle,
    super.fatherLastJobCompany,
    super.motherName,
    super.motherStatus,
    super.motherAge,
    super.motherLastEducation,
    super.motherLastJobTitle,
    super.motherLastJobCompany,
    super.maritalStatus,
    super.maritalYear,
    super.coupleName,
    super.coupleAge,
    super.coupleLastEducation,
  });

  factory FamilyInfoModel.fromJson(Map<String, dynamic> json) {
    return FamilyInfoModel(
      fatherName: json['father_name'] as String?,
      fatherStatus: json['father_status'] as int?,
      fatherAge: json['father_age'] as int?,
      fatherLastEducation: json['father_last_education'] as String?,
      fatherLastJobTitle: json['father_last_job_title'] as String?,
      fatherLastJobCompany: json['father_last_job_company'] as String?,
      motherName: json['mother_name'] as String?,
      motherStatus: json['mother_status'] as int?,
      motherAge: json['mother_age'] as int?,
      motherLastEducation: json['mother_last_education'] as String?,
      motherLastJobTitle: json['mother_last_job_title'] as String?,
      motherLastJobCompany: json['mother_last_job_company'] as String?,
      maritalStatus: json['marital_status'] as String?,
      maritalYear: json['marital_year'] as int?,
      coupleName: json['couple_name'] as String?,
      coupleAge: json['couple_age'] as int?,
      coupleLastEducation: json['couple_last_education'] as String?,
    );
  }
}

class SiblingInfoModel extends SiblingInfo {
  const SiblingInfoModel({
    required super.id,
    required super.employeeId,
    super.siblingName,
    super.siblingGender,
    super.siblingAge,
    super.siblingStatus,
    super.siblingLastEducation,
    super.siblingLastJobTitle,
    super.siblingLastJobCompany,
  });

  factory SiblingInfoModel.fromJson(Map<String, dynamic> json) {
    return SiblingInfoModel(
      id: json['id'] as int? ?? 0,
      employeeId: json['employee_id'] as int? ?? 0,
      siblingName: json['sibling_name'] as String?,
      siblingGender: json['sibling_gender'] as String?,
      siblingAge: json['sibling_age'] as int?,
      siblingStatus: json['sibling_status'] as int?,
      siblingLastEducation: json['sibling_last_education'] as String?,
      siblingLastJobTitle: json['sibling_last_job_title'] as String?,
      siblingLastJobCompany: json['sibling_last_job_company'] as String?,
    );
  }
}

class ChildInfoModel extends ChildInfo {
  const ChildInfoModel({
    required super.id,
    required super.employeeId,
    super.childName,
    super.childGender,
    super.childAge,
    super.childLastEducation,
    super.childLastJobTitle,
    super.childLastJobCompany,
    super.childStatus,
  });

  factory ChildInfoModel.fromJson(Map<String, dynamic> json) {
    return ChildInfoModel(
      id: json['id'] as int? ?? 0,
      employeeId: json['employee_id'] as int? ?? 0,
      childName: json['child_name'] as String?,
      childGender: json['child_gender'] as String?,
      childAge: json['child_age'] as int?,
      childLastEducation: json['child_last_education'] as String?,
      childLastJobTitle: json['child_last_job_title'] as String?,
      childLastJobCompany: json['child_last_job_company'] as String?,
      childStatus: json['child_status'] as int?,
    );
  }
}

class EmployeeFullDataModel extends EmployeeFullData {
  const EmployeeFullDataModel({
    required super.id,
    super.biodata,
    super.education,
    super.family,
    super.siblings,
    super.children,
  });

  factory EmployeeFullDataModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? json;

    BiodataInfo? biodataInfo;
    if (data['biodata'] != null) {
      biodataInfo = BiodataInfoModel.fromJson(data['biodata'] as Map<String, dynamic>);
    }

    EducationInfo? educationInfo;
    if (data['education'] != null) {
      educationInfo = EducationInfoModel.fromJson(data['education'] as Map<String, dynamic>);
    }

    FamilyInfo? familyInfo;
    if (data['family'] != null) {
      familyInfo = FamilyInfoModel.fromJson(data['family'] as Map<String, dynamic>);
    }

    final siblingList = (data['sibling'] as List<dynamic>? ?? [])
        .map((s) => SiblingInfoModel.fromJson(s as Map<String, dynamic>))
        .toList();

    final childList = (data['children'] as List<dynamic>? ?? [])
        .map((c) => ChildInfoModel.fromJson(c as Map<String, dynamic>))
        .toList();

    return EmployeeFullDataModel(
      id: data['id'] as int? ?? 0,
      biodata: biodataInfo,
      education: educationInfo,
      family: familyInfo,
      siblings: siblingList,
      children: childList,
    );
  }
}
