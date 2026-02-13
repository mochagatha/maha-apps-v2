import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../entities/punishment_setting.dart';
import '../repositories/ubah_periode_surat_repository.dart';

class UpdatePunishmentSetting implements UseCase<PunishmentSetting, UpdatePunishmentSettingParams> {
  final UbahPeriodeSuratRepository repository;

  UpdatePunishmentSetting(this.repository);

  @override
  Future<Either<Failure, PunishmentSetting>> call(UpdatePunishmentSettingParams params) async {
    return await repository.updatePunishmentSetting(
      isActive: params.isActive,
      longPunishment: params.longPunishment,
      loanPoint: params.loanPoint,
    );
  }
}

class UpdatePunishmentSettingParams extends Equatable {
  final bool isActive;
  final int longPunishment;
  final bool loanPoint;

  const UpdatePunishmentSettingParams({
    required this.isActive,
    required this.longPunishment,
    required this.loanPoint,
  });

  @override
  List<Object?> get props => [isActive, longPunishment, loanPoint];
}
