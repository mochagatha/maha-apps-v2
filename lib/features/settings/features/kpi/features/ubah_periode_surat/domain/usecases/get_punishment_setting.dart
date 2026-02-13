import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../entities/punishment_setting.dart';
import '../repositories/ubah_periode_surat_repository.dart';

class GetPunishmentSetting implements UseCase<PunishmentSetting, NoParams> {
  final UbahPeriodeSuratRepository repository;

  GetPunishmentSetting(this.repository);

  @override
  Future<Either<Failure, PunishmentSetting>> call(NoParams params) async {
    return await repository.getPunishmentSetting();
  }
}
