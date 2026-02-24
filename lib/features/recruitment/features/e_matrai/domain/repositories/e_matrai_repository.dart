import 'package:dartz/dartz.dart';
import 'package:maha_apps_v2/core/error/failures.dart';
import '../entities/e_matrai_list.dart';

abstract class EMatraiRepository {
  /// Fetch e-matrai list.
  ///
  /// [matraiStatus] – 0 = baru, 1 = upload, 2 = selesai
  /// [typeUser]    – "employee" or "worker"
  Future<Either<Failure, EMatraiList>> getEMatraiList({
    required int matraiStatus,
    required String typeUser,
  });
}
