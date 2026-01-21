import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class VerifyCompanyCode implements UseCase<bool, VerifyCompanyCodeParams> {
  final AuthRepository repository;

  VerifyCompanyCode(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyCompanyCodeParams params) async {
    return await repository.verifyCompanyCode(params.code);
  }
}

class VerifyCompanyCodeParams {
  final String code;

  VerifyCompanyCodeParams({required this.code});
}
