import 'package:dartz/dartz.dart';
import '../../../../../../../../../core/error/failures.dart';
import '../entities/kpi_indicators_data.dart';

/// Update payload: list of {id, value} pairs
class KpiIndicatorUpdateItem {
  final int id;
  final int value;

  const KpiIndicatorUpdateItem({required this.id, required this.value});
}

abstract class PenilaianKinerjaRepository {
  /// Fetch all KPI indicators (Kehadiran, Penilaian Atasan, Rencana Kerja, Tugas)
  Future<Either<Failure, KpiIndicatorsData>> getKpiIndicators();

  /// Update multiple KPI indicators in one request
  Future<Either<Failure, void>> updateManyKpiIndicators(
    List<KpiIndicatorUpdateItem> items,
  );
}
