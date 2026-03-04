import 'package:dartz/dartz.dart';
import 'package:maha_apps_v2/core/error/exceptions.dart';
import 'package:maha_apps_v2/core/error/failures.dart';
import 'package:maha_apps_v2/core/network/network_info.dart';
import '../../domain/entities/e_matrai_list.dart';
import '../../domain/repositories/e_matrai_repository.dart';
import '../datasources/e_matrai_remote_datasource.dart';

class EMatraiRepositoryImpl implements EMatraiRepository {
  final EMatraiRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  EMatraiRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, EMatraiList>> getEMatraiList({
    required int matraiStatus,
    required String typeUser,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }
    try {
      final result = await remoteDataSource.getEMatraiList(
        matraiStatus: matraiStatus,
        typeUser: typeUser,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> uploadMatrai({
    required int employeeAgreementId,
    required String filePath,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }
    try {
      await remoteDataSource.uploadMatrai(
        employeeAgreementId: employeeAgreementId,
        filePath: filePath,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
