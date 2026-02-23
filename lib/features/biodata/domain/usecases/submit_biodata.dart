import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/biodata_repository.dart';

class SubmitBiodata implements UseCase<void, SubmitBiodataParams> {
  final BiodataRepository repository;

  SubmitBiodata(this.repository);

  @override
  Future<Either<Failure, void>> call(SubmitBiodataParams params) async {
    return await repository.submitBiodata(params.toBody());
  }
}

class SubmitBiodataParams extends Equatable {
  final int employeeId;
  final String fullname;
  final String nickname;
  final String nik;
  final String identityProvince;
  final String identityRegency;
  final String identityDistrict;
  final String identityVillage;
  final int identityPostalCode;
  final String identityAddress;
  final String currentProvince;
  final String currentRegency;
  final String currentDistrict;
  final String currentVillage;
  final int currentPostalCode;
  final String currentAddress;
  final String residenceStatus;
  final String phoneNumber;
  final String emergencyPhoneNumber;
  final String gender;
  final String birthPlace;
  final String birthDate; // yyyy-MM-dd
  final String religion;

  const SubmitBiodataParams({
    required this.employeeId,
    required this.fullname,
    required this.nickname,
    required this.nik,
    required this.identityProvince,
    required this.identityRegency,
    required this.identityDistrict,
    required this.identityVillage,
    required this.identityPostalCode,
    required this.identityAddress,
    required this.currentProvince,
    required this.currentRegency,
    required this.currentDistrict,
    required this.currentVillage,
    required this.currentPostalCode,
    required this.currentAddress,
    required this.residenceStatus,
    required this.phoneNumber,
    required this.emergencyPhoneNumber,
    required this.gender,
    required this.birthPlace,
    required this.birthDate,
    required this.religion,
  });

  Map<String, dynamic> toBody() => {
    'employee_id': employeeId,
    'fullname': fullname,
    'nickname': nickname,
    'nik': nik,
    'identity_province': identityProvince,
    'identity_regency': identityRegency,
    'identity_district': identityDistrict,
    'identity_village': identityVillage,
    'identity_postal_code': identityPostalCode,
    'identity_address': identityAddress,
    'current_province': currentProvince,
    'current_regency': currentRegency,
    'current_district': currentDistrict,
    'current_village': currentVillage,
    'current_postal_code': currentPostalCode,
    'current_address': currentAddress,
    'residence_status': residenceStatus,
    'phone_number': phoneNumber,
    'emergency_phone_number': emergencyPhoneNumber,
    'gender': gender,
    'birth_place': birthPlace,
    'birth_date': birthDate,
    'religion': religion,
  };

  @override
  List<Object?> get props => [
    employeeId,
    fullname,
    nickname,
    nik,
    identityProvince,
    identityRegency,
    identityDistrict,
    identityVillage,
    identityPostalCode,
    identityAddress,
    currentProvince,
    currentRegency,
    currentDistrict,
    currentVillage,
    currentPostalCode,
    currentAddress,
    residenceStatus,
    phoneNumber,
    emergencyPhoneNumber,
    gender,
    birthPlace,
    birthDate,
    religion,
  ];
}
