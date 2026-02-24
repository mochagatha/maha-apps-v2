import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/biodata.dart';
import '../../domain/entities/region.dart';
import '../../domain/repositories/biodata_repository.dart';
import '../datasources/biodata_remote_datasource.dart';

class BiodataRepositoryImpl implements BiodataRepository {
  final BiodataRemoteDataSource remoteDataSource;

  BiodataRepositoryImpl({required this.remoteDataSource});

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
}
