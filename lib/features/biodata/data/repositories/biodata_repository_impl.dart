import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/bank.dart';
import '../../domain/entities/biodata.dart';
import '../../domain/entities/employee_full_data.dart';
import '../../domain/entities/region.dart';
import '../../domain/entities/revision_verification.dart';
import '../../domain/entities/user_photo.dart';
import '../../domain/repositories/biodata_repository.dart';
import '../datasources/biodata_remote_datasource.dart';

class BiodataRepositoryImpl implements BiodataRepository {
  final BiodataRemoteDataSource remoteDataSource;

  BiodataRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Bank>>> getBanks() async {
    try {
      final models = await remoteDataSource.getBanks();
      return Right(models);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitBank({
    required int employeeId,
    required int bankId,
    required String accountNumber,
    required String accountName,
  }) async {
    try {
      await remoteDataSource.submitBank(
        employeeId: employeeId,
        bankId: bankId,
        accountNumber: accountNumber,
        accountName: accountName,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Biodata>> getBiodata() async {
    try {
      final remoteBiodata = await remoteDataSource.getBiodata();
      return Right(remoteBiodata);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Province>>> getProvinces() async {
    try {
      final remoteProvinces = await remoteDataSource.getProvinces();
      return Right(remoteProvinces.map((m) => Province(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Regency>>> getRegencies(String provinceId) async {
    try {
      final remoteRegencies = await remoteDataSource.getRegencies(provinceId);
      return Right(remoteRegencies.map((m) => Regency(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<District>>> getDistricts(String regencyId) async {
    try {
      final remoteDistricts = await remoteDataSource.getDistricts(regencyId);
      return Right(remoteDistricts.map((m) => District(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Village>>> getVillages(String districtId) async {
    try {
      final remoteVillages = await remoteDataSource.getVillages(districtId);
      return Right(remoteVillages.map((m) => Village(id: m.id, name: m.name)).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitBiodata(Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitBiodata(body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitEducation(Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitEducation(body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitFamily(Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitFamily(body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitSibling(Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitSibling(body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitMarital(int employeeId, Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitMarital(employeeId, body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitChildren(Map<String, dynamic> body) async {
    try {
      await remoteDataSource.submitChildren(body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
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
  }) async {
    try {
      await remoteDataSource.submitDocument(
        employeeId: employeeId,
        photoPath: photoPath,
        ktpPath: ktpPath,
        kkPath: kkPath,
        certificatePath: certificatePath,
        gradeTranscriptPath: gradeTranscriptPath,
        certificateSkillPath: certificateSkillPath,
        bankAccountPath: bankAccountPath,
        npwpPath: npwpPath,
        bpjsKtnPath: bpjsKtnPath,
        bpjsKesPath: bpjsKesPath,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, RevisionVerification>> getRevisionVerification(int employeeId) async {
    try {
      final result = await remoteDataSource.getRevisionVerification(employeeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, EmployeeFullData>> getEmployeeFullData(int employeeId) async {
    try {
      final result = await remoteDataSource.getEmployeeFullData(employeeId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitRevision({
    required int employeeId,
    required Map<String, dynamic> body,
  }) async {
    try {
      await remoteDataSource.submitRevision(employeeId: employeeId, body: body);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitSkill({
    required int employeeId,
    required List<String> skills,
  }) async {
    try {
      await remoteDataSource.submitSkill(
        employeeId: employeeId,
        skills: skills,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitSignature({
    required int employeeId,
    required String signaturePath,
  }) async {
    try {
      await remoteDataSource.submitSignature(
        employeeId: employeeId,
        signaturePath: signaturePath,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitEmployeeDocument({
    required int employeeId,
    required String photoWithKtpPath,
  }) async {
    try {
      await remoteDataSource.submitEmployeeDocument(
        employeeId: employeeId,
        photoWithKtpPath: photoWithKtpPath,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> submitUserPhoto(UserPhoto userPhoto) async {
    try {
      await remoteDataSource.submitUserPhoto(userPhoto);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
