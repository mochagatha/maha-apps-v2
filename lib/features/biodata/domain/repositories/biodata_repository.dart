import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/biodata.dart';

abstract class BiodataRepository {
  Future<Either<Failure, Biodata>> getBiodata();
}
