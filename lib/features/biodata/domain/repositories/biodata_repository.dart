import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/biodata.dart';
import '../entities/region.dart';

abstract class BiodataRepository {
  Future<Either<Failure, Biodata>> getBiodata();
  Future<Either<Failure, List<Province>>> getProvinces();
  Future<Either<Failure, List<Regency>>> getRegencies(String provinceId);
  Future<Either<Failure, List<District>>> getDistricts(String regencyId);
  Future<Either<Failure, List<Village>>> getVillages(String districtId);
  Future<Either<Failure, void>> submitBiodata(Map<String, dynamic> body);
  Future<Either<Failure, void>> submitEducation(Map<String, dynamic> body);
}
