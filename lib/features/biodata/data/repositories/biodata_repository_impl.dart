import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/biodata.dart';
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
}
