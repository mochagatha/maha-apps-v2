import 'package:dartz/dartz.dart';
import '../../../../../../../../core/error/failures.dart';
import '../entities/employee_kpi_entity.dart';
import '../entities/kpi_settings_entity.dart';

/// Repository interface for Aktivasi Point (KPI Settings)
abstract class AktivasiPointRepository {
  /// Get KPI settings with employee list
  Future<Either<Failure, KpiSettings>> getKpiSettings();

  /// Get KPI setting for a specific employee by ID
  Future<Either<Failure, EmployeeKpi>> getEmployeeKpiById(int employeeId);

  /// Update global KPI activation setting
  Future<Either<Failure, void>> updateGlobalKpiSetting({required bool isActive});

  /// Update specific employee KPI activation setting
  Future<Either<Failure, void>> updateEmployeeKpiSetting({
    required int employeeId,
    required bool isActive,
  });
}
