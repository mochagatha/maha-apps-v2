import 'package:equatable/equatable.dart';

/// Target Point KPI Indicator Entity
/// Represents a KPI indicator for target points
class TargetPointIndicator extends Equatable {
  final int id;
  final String name;
  final String indicatorName;
  final String operator;
  final int value;
  final String typeValue;
  final String typeIndicator;

  const TargetPointIndicator({
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
