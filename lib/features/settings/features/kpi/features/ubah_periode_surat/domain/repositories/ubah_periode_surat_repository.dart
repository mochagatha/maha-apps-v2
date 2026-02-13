import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../entities/punishment_setting.dart';

abstract class UbahPeriodeSuratRepository {
  Future<Either<Failure, PunishmentSetting>> getPunishmentSetting();
  Future<Either<Failure, PunishmentSetting>> updatePunishmentSetting({
    required bool isActive,
    required int longPunishment,
    required bool loanPoint,
  });
}
