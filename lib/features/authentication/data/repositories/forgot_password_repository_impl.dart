import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/forgot_password_status.dart';
import '../../domain/entities/forgot_password_verification_data.dart';
import '../../domain/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_remote_datasource.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ForgotPasswordRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ForgotPasswordStatus>> sendOtp(String email) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.sendOtp(email);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('Tidak ada koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, ForgotPasswordVerificationData>> verifyOtp(String email, String code) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteData = await remoteDataSource.verifyOtp(email, code);
        return Right(remoteData);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('Tidak ada koneksi internet'));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(
    int id,
    String oldPassword,
    String password,
    String confirmationPassword,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(
          id,
          oldPassword,
          password,
          confirmationPassword,
        );
        return const Right(null);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      }
    } else {
      return Left(NetworkFailure('Tidak ada koneksi internet'));
    }
  }
}
