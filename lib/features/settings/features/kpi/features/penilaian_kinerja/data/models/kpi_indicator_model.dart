import '../../domain/entities/kpi_indicator.dart';

class KpiIndicatorModel extends KpiIndicator {
  const KpiIndicatorModel({
    required super.id,
    required super.name,
    required super.indicatorName,
    required super.operator,
    required super.value,
    required super.typeValue,
    required super.typeIndicator,
  });

  factory KpiIndicatorModel.fromJson(Map<String, dynamic> json) {
    return KpiIndicatorModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      indicatorName: json['indicator_name'] ?? '',
      operator: json['operator'] ?? '',
      value: json['value'] is int
          ? json['value'] as int
          : int.tryParse(json['value'].toString()) ?? 0,
      typeValue: json['type_value'] ?? '',
      typeIndicator: json['type_indicator'] ?? '',
    );
  }

  KpiIndicator toEntity() => KpiIndicator(
    id: id,
    name: name,
    indicatorName: indicatorName,
    operator: operator,
    value: value,
    typeValue: typeValue,
    typeIndicator: typeIndicator,
  );
}
