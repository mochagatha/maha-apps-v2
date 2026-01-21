import '../../domain/entities/kpi.dart';

class KpiModel extends Kpi {
  const KpiModel({
    super.month,
    super.year,
    super.targetPoint,
    super.totalPoint,
    super.percentage,
    super.totalEmployee,
    super.message,
  });

  factory KpiModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final data = json['data'];
      return KpiModel(
        month: data['month'],
        year: data['year'],
        targetPoint: data['target_point'],
        totalPoint: (data['total_point'] as num?)?.round(),
        percentage: (data['percentage'] is int)
            ? (data['percentage'] as int).toDouble()
            : (data['percentage'] as num?)?.toDouble(),
        totalEmployee: data['total_employee'],
      );
    } else {
      return KpiModel(message: json['message'] as String?);
    }
  }

  Kpi toEntity() {
    return Kpi(
      month: month,
      year: year,
      targetPoint: targetPoint,
      totalPoint: totalPoint,
      percentage: percentage,
      totalEmployee: totalEmployee,
      message: message,
    );
  }
}
