import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/employee.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_local_datasource.dart';
import '../datasources/profile_remote_datasource.dart';

/// Implementation of ProfileRepository
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ProfileRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Employee>> getProfile() async {
    if (await networkInfo.isConnected) {
      try {
        final employeeModel = await remoteDataSource.getProfile();
        // Cache the profile data
        await localDataSource.cacheProfile(employeeModel);
        return Right(employeeModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      // Try to get cached data when offline
      try {
        final cachedEmployee = await localDataSource.getCachedProfile();
        if (cachedEmployee != null) {
          return Right(cachedEmployee.toEntity());
        } else {
          return const Left(
            NetworkFailure('No internet connection and no cached data available'),
          );
        }
      } on CacheException catch (e) {
        return Left(CacheFailure(e.message));
      }
    }
  }

  @override
  Future<Either<Failure, Employee>> updateProfile(
    Map<String, dynamic> params,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final employeeModel = await remoteDataSource.updateProfile(params);
        // Update cache with new data
        await localDataSource.cacheProfile(employeeModel);
        return Right(employeeModel.toEntity());
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        NetworkFailure('No internet connection. Cannot update profile.'),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateProfilePicture(File image) async {
    if (await networkInfo.isConnected) {
      try {
        final photoUrl = await remoteDataSource.updateProfilePicture(image);
        return Right(photoUrl);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message));
      } catch (e) {
        return Left(ServerFailure(e.toString()));
      }
    } else {
      return const Left(
        NetworkFailure('No internet connection. Cannot upload picture.'),
      );
    }
  }
}
