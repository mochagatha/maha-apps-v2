import 'package:equatable/equatable.dart';

class BiodataInfo extends Equatable {
  final int id;
  final int employeeId;
  final String fullname;
  final String? nickname;
  final String? nik;
  final int? identityProvince;
  final int? identityRegency;
  final int? identityDistrict;
  final int? identityVillage;
  final int? identityPostalCode;
  final String? identityAddress;
  final int? currentProvince;
  final int? currentRegency;
  final int? currentDistrict;
  final int? currentVillage;
  final int? currentPostalCode;
  final String? currentAddress;
  final String? residenceStatus;
  final String? phoneNumber;
  final String? emergencyPhoneNumber;
  final String? gender;
  final String? birthPlace;
  final String? birthDate;
  final String? religion;
  final String? bloodType;
  final int? weight;
  final int? height;

  const BiodataInfo({
    required this.id,
    required this.employeeId,
    required this.fullname,
    this.nickname,
    this.nik,
    this.identityProvince,
    this.identityRegency,
    this.identityDistrict,
    this.identityVillage,
    this.identityPostalCode,
    this.identityAddress,
    this.currentProvince,
    this.currentRegency,
    this.currentDistrict,
    this.currentVillage,
    this.currentPostalCode,
    this.currentAddress,
    this.residenceStatus,
    this.phoneNumber,
    this.emergencyPhoneNumber,
    this.gender,
    this.birthPlace,
    this.birthDate,
    this.religion,
    this.bloodType,
    this.weight,
    this.height,
  });

  @override
  List<Object?> get props => [id, employeeId, fullname, nickname, nik];
}

class EducationInfo extends Equatable {
  final String? lastEducation;
  final String? primarySchool;
  final String? psStartYear;
  final String? psEndYear;
  final String? juniorHighSchool;
  final String? jhsStartYear;
  final String? jhsEndYear;
  final String? seniorHighSchool;
  final String? shsStartYear;
  final String? shsEndYear;
  final String? shsGpa;
  final String? bachelorUniversity;
  final String? bachelorMajor;
  final String? bachelorStartYear;
  final String? bachelorEndYear;
  final String? bachelorGpa;
  final String? bachelorDegree;
  final String? masterUniversity;
  final String? masterMajor;
  final String? masterStartYear;
  final String? masterEndYear;
  final String? masterGpa;
  final String? masterDegree;
  final String? doctoralUniversity;
  final String? doctoralMajor;
  final String? doctoralStartYear;
  final String? doctoralEndYear;
  final String? doctoralGpa;
  final String? doctoralDegree;
  final String? lastEducationMajor;

  const EducationInfo({
    this.lastEducation,
    this.primarySchool,
    this.psStartYear,
    this.psEndYear,
    this.juniorHighSchool,
    this.jhsStartYear,
    this.jhsEndYear,
    this.seniorHighSchool,
    this.shsStartYear,
    this.shsEndYear,
    this.shsGpa,
    this.bachelorUniversity,
    this.bachelorMajor,
    this.bachelorStartYear,
    this.bachelorEndYear,
    this.bachelorGpa,
    this.bachelorDegree,
    this.masterUniversity,
    this.masterMajor,
    this.masterStartYear,
    this.masterEndYear,
    this.masterGpa,
    this.masterDegree,
    this.doctoralUniversity,
    this.doctoralMajor,
    this.doctoralStartYear,
    this.doctoralEndYear,
    this.doctoralGpa,
    this.doctoralDegree,
    this.lastEducationMajor,
  });

  @override
  List<Object?> get props => [lastEducation, seniorHighSchool, bachelorUniversity];
}

class FamilyInfo extends Equatable {
  final String? fatherName;
  final int? fatherStatus;
  final int? fatherAge;
  final String? fatherLastEducation;
  final String? fatherLastJobTitle;
  final String? fatherLastJobCompany;
  final String? motherName;
  final int? motherStatus;
  final int? motherAge;
  final String? motherLastEducation;
  final String? motherLastJobTitle;
  final String? motherLastJobCompany;
  final String? maritalStatus;
  final int? maritalYear;
  final String? coupleName;
  final int? coupleAge;
  final String? coupleLastEducation;

  const FamilyInfo({
    this.fatherName,
    this.fatherStatus,
    this.fatherAge,
    this.fatherLastEducation,
    this.fatherLastJobTitle,
    this.fatherLastJobCompany,
    this.motherName,
    this.motherStatus,
    this.motherAge,
    this.motherLastEducation,
    this.motherLastJobTitle,
    this.motherLastJobCompany,
    this.maritalStatus,
    this.maritalYear,
    this.coupleName,
    this.coupleAge,
    this.coupleLastEducation,
  });

  @override
  List<Object?> get props => [fatherName, motherName, coupleName];
}

class SiblingInfo extends Equatable {
  final int id;
  final int employeeId;
  final String? siblingName;
  final String? siblingGender;
  final int? siblingAge;
  final int? siblingStatus;
  final String? siblingLastEducation;
  final String? siblingLastJobTitle;
  final String? siblingLastJobCompany;

  const SiblingInfo({
    required this.id,
    required this.employeeId,
    this.siblingName,
    this.siblingGender,
    this.siblingAge,
    this.siblingStatus,
    this.siblingLastEducation,
    this.siblingLastJobTitle,
    this.siblingLastJobCompany,
  });

  @override
  List<Object?> get props => [id, employeeId, siblingName];
}

class ChildInfo extends Equatable {
  final int id;
  final int employeeId;
  final String? childName;
  final String? childGender;
  final int? childAge;
  final String? childLastEducation;
  final String? childLastJobTitle;
  final String? childLastJobCompany;
  final int? childStatus;

  const ChildInfo({
    required this.id,
    required this.employeeId,
    this.childName,
    this.childGender,
    this.childAge,
    this.childLastEducation,
    this.childLastJobTitle,
    this.childLastJobCompany,
    this.childStatus,
  });

  @override
  List<Object?> get props => [id, employeeId, childName];
}

class EmployeeFullData extends Equatable {
  final int id;
  final BiodataInfo? biodata;
  final EducationInfo? education;
  final FamilyInfo? family;
  final List<SiblingInfo> siblings;
  final List<ChildInfo> children;

  const EmployeeFullData({
    required this.id,
    this.biodata,
    this.education,
    this.family,
    this.siblings = const [],
    this.children = const [],
  });

  @override
  List<Object?> get props => [id, biodata, education, family, siblings, children];
}
