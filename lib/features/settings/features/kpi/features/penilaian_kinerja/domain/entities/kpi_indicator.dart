import 'package:equatable/equatable.dart';

/// KPI Indicator entity for Kehadiran, Penilaian Atasan, and Target Poin items
class KpiIndicator extends Equatable {
  final int id;
  final String name;
  final String indicatorName;
  final String operator;
  final int value;
  final String typeValue;
  final String typeIndicator;

  const KpiIndicator({
    required this.id,
    required this.name,
    required this.indicatorName,
    required this.operator,
    required this.value,
    required this.typeValue,
    required this.typeIndicator,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    indicatorName,
    operator,
    value,
    typeValue,
    typeIndicator,
  ];
}
