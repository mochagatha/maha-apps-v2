import 'package:equatable/equatable.dart';

class Kpi extends Equatable {
  final int? month;
  final int? year;
  final int? targetPoint;
  final int? totalPoint;
  final double? percentage;
  final int? totalEmployee;
  final String? message;

  const Kpi({
    this.month,
    this.year,
    this.targetPoint,
    this.totalPoint,
    this.percentage,
    this.totalEmployee,
    this.message,
  });

  @override
  List<Object?> get props => [
    month,
    year,
    targetPoint,
    totalPoint,
    percentage,
    totalEmployee,
    message,
  ];
}
