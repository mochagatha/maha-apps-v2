import 'package:equatable/equatable.dart';

class PunishmentSetting extends Equatable {
  final int id;
  final bool isActive;
  final int longPunishment;
  final bool loanPoint;

  const PunishmentSetting({
    required this.id,
    required this.isActive,
    required this.longPunishment,
    required this.loanPoint,
  });

  @override
  List<Object?> get props => [id, isActive, longPunishment, loanPoint];
}
