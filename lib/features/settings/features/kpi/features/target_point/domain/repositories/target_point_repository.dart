import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../entities/target_point_indicator.dart';

/// Repository interface for Target Point KPI operations
abstract class TargetPointRepository {
  /// Get target point indicators from API
  /// Query parameter: type_indicator=Target Poin
  Future<Either<Failure, List<TargetPointIndicator>>> getTargetPointIndicators();

  /// Update target point indicator value
  /// PUT endpoint: employee/kpi-indicator/update/{id}
  /// Body: {"value": newValue}
  Future<Either<Failure, void>> updateTargetPointIndicator({
    required int id,
    required int value,
  });
}
