import '../../domain/entities/punishment_setting.dart';

class PunishmentSettingModel extends PunishmentSetting {
  const PunishmentSettingModel({
    required int id,
    required bool isActive,
    required int longPunishment,
    required bool loanPoint,
  }) : super(
         id: id,
         isActive: isActive,
         longPunishment: longPunishment,
         loanPoint: loanPoint,
       );

  factory PunishmentSettingModel.fromJson(Map<String, dynamic> json) {
    return PunishmentSettingModel(
      id: json['id'] ?? 0,
      isActive: json['is_active'] ?? false,
      longPunishment: json['long_punishment'] ?? 0,
      loanPoint: json['loan_point'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'is_active': isActive,
      'long_punishment': longPunishment,
      'loan_point': loanPoint,
    };
  }
}
