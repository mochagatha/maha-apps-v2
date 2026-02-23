import '../../domain/entities/target_point_indicator.dart';

/// Model for Target Point KPI Indicator
/// Extends entity and adds JSON serialization
class TargetPointIndicatorModel extends TargetPointIndicator {
  const TargetPointIndicatorModel({
    required super.id,
    required super.name,
    required super.indicatorName,
    required super.operator,
    required super.value,
    required super.typeValue,
    required super.typeIndicator,
  });

  /// Create model from JSON (API response)
  factory TargetPointIndicatorModel.fromJson(Map<String, dynamic> json) {
    return TargetPointIndicatorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      indicatorName: json['indicator_name'] ?? '',
      operator: json['operator'] ?? '',
      value: json['value'] is int ? json['value'] : int.tryParse(json['value'].toString()) ?? 0,
      typeValue: json['type_value'] ?? '',
      typeIndicator: json['type_indicator'] ?? '',
    );
  }

  /// Convert model to JSON (API request)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'indicator_name': indicatorName,
      'operator': operator,
      'value': value,
      'type_value': typeValue,
      'type_indicator': typeIndicator,
    };
  }

  /// Convert model to entity
  TargetPointIndicator toEntity() {
    return TargetPointIndicator(
      id: id,
      name: name,
      indicatorName: indicatorName,
      operator: operator,
      value: value,
      typeValue: typeValue,
      typeIndicator: typeIndicator,
    );
  }
}
