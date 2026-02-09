import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/tracking_settings.dart';
import '../repositories/pelacakan_repository.dart';

class GetTrackingSettings implements UseCase<TrackingSettings, TrackingSettingsParams> {
  final PelacakanRepository repository;

  GetTrackingSettings(this.repository);

  @override
  Future<Either<Failure, TrackingSettings>> call(TrackingSettingsParams params) async {
    return await repository.getTrackingSettings(params.employeeType);
  }
}

class TrackingSettingsParams extends Equatable {
  final String employeeType;

  const TrackingSettingsParams({required this.employeeType});

  @override
  List<Object?> get props => [employeeType];
}
