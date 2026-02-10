import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/error/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../repositories/pelacakan_repository.dart';

class SaveTrackingSettings implements UseCase<void, SaveTrackingParams> {
  final PelacakanRepository repository;

  SaveTrackingSettings(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveTrackingParams params) async {
    return await repository.saveTrackingSettings(
      employeeType: params.employeeType,
      isGlobalEnabled: params.isGlobalEnabled,
      enabledEmployeeIds: params.enabledEmployeeIds,
    );
  }
}

class SaveTrackingParams extends Equatable {
  final String employeeType;
  final bool isGlobalEnabled;
  final List<int> enabledEmployeeIds;

  const SaveTrackingParams({
    required this.employeeType,
    required this.isGlobalEnabled,
    required this.enabledEmployeeIds,
  });

  @override
  List<Object?> get props => [employeeType, isGlobalEnabled, enabledEmployeeIds];
}
