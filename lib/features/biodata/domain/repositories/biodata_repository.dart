import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/bank.dart';
import '../entities/biodata.dart';
import '../entities/employee_full_data.dart';
import '../entities/region.dart';
import '../entities/revision_verification.dart';
import '../entities/user_photo.dart';

abstract class BiodataRepository {
  Future<Either<Failure, List<Bank>>> getBanks();
  Future<Either<Failure, void>> submitBank({
    required int employeeId,
    required int bankId,
    required String accountNumber,
    required String accountName,
  });
  Future<Either<Failure, Biodata>> getBiodata();
  Future<Either<Failure, List<Province>>> getProvinces();
  Future<Either<Failure, List<Regency>>> getRegencies(String provinceId);
  Future<Either<Failure, List<District>>> getDistricts(String regencyId);
  Future<Either<Failure, List<Village>>> getVillages(String districtId);
  Future<Either<Failure, void>> submitBiodata(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitEducation(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitFamily(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitSibling(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitMarital(int employeeId, Map<String, dynamic> body);
  Future<Either<Failure, void>> submitChildren(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitDocument({
    required int employeeId,
    required String photoPath,
    required String ktpPath,
    required String kkPath,
    required String certificatePath,
    required String gradeTranscriptPath,
    String? certificateSkillPath,
    String? bankAccountPath,
    String? npwpPath,
    String? bpjsKtnPath,
    String? bpjsKesPath,
  });
  Future<Either<Failure, RevisionVerification>> getRevisionVerification(int employeeId);
  Future<Either<Failure, EmployeeFullData>> getEmployeeFullData(int employeeId);
  Future<Either<Failure, void>> submitRevision({
    required int employeeId,
    required Map<String, dynamic> body,
  });
  Future<Either<Failure, void>> submitSkill({
    required int employeeId,
    required List<String> skills,
  });
  Future<Either<Failure, void>> submitSignature({
    required int employeeId,
    required String signaturePath,
  });
  Future<Either<Failure, void>> submitEmployeeDocument({
    required int employeeId,
    required String photoWithKtpPath,
  });
  Future<Either<Failure, void>> submitUserPhoto(UserPhoto userPhoto);
}
