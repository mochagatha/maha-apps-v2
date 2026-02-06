import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/screen_security_entity.dart';
import '../repositories/screen_security_repository.dart';

class GetScreenSecuritySettings implements UseCase<ScreenSecurityEntity, ScreenSecurityParams> {
  final ScreenSecurityRepository repository;

  GetScreenSecuritySettings(this.repository);

  @override
  Future<Either<Failure, ScreenSecurityEntity>> call(ScreenSecurityParams params) async {
    return await repository.getScreenSecuritySettings(
      type: params.type,
      employeeWorkerId: params.employeeWorkerId,
    );
  }
}

class ScreenSecurityParams extends Equatable {
  final String type;
  final int employeeWorkerId;

  const ScreenSecurityParams({required this.type, required this.employeeWorkerId});

  @override
  List<Object?> get props => [type, employeeWorkerId];
}
