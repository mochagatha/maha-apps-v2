import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../repositories/target_point_repository.dart';

/// Use case for updating target point KPI indicator value
class UpdateTargetPointIndicator implements UseCase<void, UpdateTargetPointParams> {
  final TargetPointRepository repository;

  UpdateTargetPointIndicator(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateTargetPointParams params) async {
    return await repository.updateTargetPointIndicator(
      id: params.id,
      value: params.value,
    );
  }
}

/// Parameters for updating target point indicator
class UpdateTargetPointParams extends Equatable {
  final int id;
  final int value;

  const UpdateTargetPointParams({
    required this.id,
    required this.value,
  });

  @override
  List<Object?> get props => [id, value];
}
