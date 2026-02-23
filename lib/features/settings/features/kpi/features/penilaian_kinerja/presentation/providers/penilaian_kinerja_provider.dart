import 'package:flutter/foundation.dart';
import '../../../../../../../../../core/error/failures.dart';
import '../../../../../../../../../core/usecases/usecase.dart';
import '../../domain/entities/kpi_indicator.dart';
import '../../domain/entities/kpi_indicators_data.dart';
import '../../domain/entities/kpi_role_indicator.dart';
import '../../domain/repositories/penilaian_kinerja_repository.dart';
import '../../domain/usecases/get_kpi_indicators.dart';
import '../../domain/usecases/update_many_kpi_indicators.dart';

/// Local mutable model for a role-based indicator (work plan / task)
class WorkPlanPosition {
  final int id;
  final String position;
  int minPoint;
  int maxPoint;

  WorkPlanPosition({
    required this.id,
    required this.position,
    required this.minPoint,
    required this.maxPoint,
  });

  factory WorkPlanPosition.fromEntity(KpiRoleIndicator entity) {
    return WorkPlanPosition(
      id: entity.id,
      position: entity.roleName,
      minPoint: entity.minPoint,
      maxPoint: entity.maxPoint,
    );
  }

  WorkPlanPosition copyWith({int? minPoint, int? maxPoint}) {
    return WorkPlanPosition(
      id: id,
      position: position,
      minPoint: minPoint ?? this.minPoint,
      maxPoint: maxPoint ?? this.maxPoint,
    );
  }
}

/// Local mutable model for a value-based indicator (attendance / supervisor)
class _IndicatorState {
  final int id;
  final String name;
  final String indicatorName;
  final String operator;
  int value;
  final String typeValue;
  final String typeIndicator;

  _IndicatorState.fromEntity(KpiIndicator e)
    : id = e.id,
      name = e.name,
      indicatorName = e.indicatorName,
      operator = e.operator,
      value = e.value,
      typeValue = e.typeValue,
      typeIndicator = e.typeIndicator;
}

/// Provider for Performance Assessment feature
class PenilaianKinerjaProvider extends ChangeNotifier {
  final GetKpiIndicators getKpiIndicatorsUseCase;
  final UpdateManyKpiIndicators updateManyKpiIndicatorsUseCase;

  PenilaianKinerjaProvider({
    required this.getKpiIndicatorsUseCase,
    required this.updateManyKpiIndicatorsUseCase,
  });

  // Raw loaded data (used for reset)
  KpiIndicatorsData? _originalData;

  List<_IndicatorState> _attendanceItems = [];
  List<_IndicatorState> _supervisorItems = [];
  List<WorkPlanPosition> _workPlanPositions = [];
  List<WorkPlanPosition> _taskPositions = [];

  bool _isLoading = false;
  String? _errorMessage;

  // ──────────────────────────────────────────────────────────────────────────
  // Getters
  // ──────────────────────────────────────────────────────────────────────────

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasData => _originalData != null;

  int get maksimalPointAbsensi => _attendanceItems.isNotEmpty ? _attendanceItems[0].value : 0;
  int get terlambat => _attendanceItems.length > 1 ? _attendanceItems[1].value : 0;
  int get tidakAbsenPulang => _attendanceItems.length > 2 ? _attendanceItems[2].value : 0;
  int get sakit => _attendanceItems.length > 3 ? _attendanceItems[3].value : 0;
  int get mangkirMasuk => _attendanceItems.length > 4 ? _attendanceItems[4].value : 0;

  int get maksimalPointAtasan => _supervisorItems.isNotEmpty ? _supervisorItems[0].value : 0;

  List<WorkPlanPosition> get workPlanPositions => List.unmodifiable(_workPlanPositions);
  List<WorkPlanPosition> get taskPositions => List.unmodifiable(_taskPositions);

  // ──────────────────────────────────────────────────────────────────────────
  // Load from API
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> loadKpiIndicators() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getKpiIndicatorsUseCase(const NoParams());

    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (data) {
        _originalData = data;
        _applyDataToState(data);
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  void _applyDataToState(KpiIndicatorsData data) {
    _attendanceItems = data.attendance.map(_IndicatorState.fromEntity).toList();
    _supervisorItems = data.supervisorAssessment.map(_IndicatorState.fromEntity).toList();
    _workPlanPositions = data.workPlan.map(WorkPlanPosition.fromEntity).toList();
    _taskPositions = data.task.map(WorkPlanPosition.fromEntity).toList();
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Update helpers (called from the page before applyChanges)
  // ──────────────────────────────────────────────────────────────────────────

  void updateMaksimalPointAbsensi(int value) {
    if (_attendanceItems.isNotEmpty) _attendanceItems[0].value = value;
    notifyListeners();
  }

  void updateTerlambat(int value) {
    if (_attendanceItems.length > 1) _attendanceItems[1].value = value;
    notifyListeners();
  }

  void updateTidakAbsenPulang(int value) {
    if (_attendanceItems.length > 2) _attendanceItems[2].value = value;
    notifyListeners();
  }

  void updateSakit(int value) {
    if (_attendanceItems.length > 3) _attendanceItems[3].value = value;
    notifyListeners();
  }

  void updateMangkirMasuk(int value) {
    if (_attendanceItems.length > 4) _attendanceItems[4].value = value;
    notifyListeners();
  }

  void updateMaksimalPointAtasan(int value) {
    if (_supervisorItems.isNotEmpty) _supervisorItems[0].value = value;
    notifyListeners();
  }

  void updateWorkPlanPosition(int index, {int? minPoint, int? maxPoint}) {
    if (index >= 0 && index < _workPlanPositions.length) {
      _workPlanPositions[index] = _workPlanPositions[index].copyWith(
        minPoint: minPoint,
        maxPoint: maxPoint,
      );
      notifyListeners();
    }
  }

  void updateTaskPosition(int index, {int? minPoint, int? maxPoint}) {
    if (index >= 0 && index < _taskPositions.length) {
      _taskPositions[index] = _taskPositions[index].copyWith(
        minPoint: minPoint,
        maxPoint: maxPoint,
      );
      notifyListeners();
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Apply / Save
  // ──────────────────────────────────────────────────────────────────────────

  Future<bool> applyChanges() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    // Build payload from attendance + supervisor items (those with a `value` field)
    final updateItems = <KpiIndicatorUpdateItem>[
      ..._attendanceItems.map(
        (e) => KpiIndicatorUpdateItem(id: e.id, value: e.value),
      ),
      ..._supervisorItems.map(
        (e) => KpiIndicatorUpdateItem(id: e.id, value: e.value),
      ),
    ];

    if (updateItems.isEmpty) {
      _isLoading = false;
      notifyListeners();
      return true;
    }

    final result = await updateManyKpiIndicatorsUseCase(
      UpdateManyKpiIndicatorsParams(items: updateItems),
    );

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Reset
  // ──────────────────────────────────────────────────────────────────────────

  void reset() {
    if (_originalData != null) {
      _applyDataToState(_originalData!);
    }
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Helpers
  // ──────────────────────────────────────────────────────────────────────────

  String _mapFailureToMessage(Failure failure) {
    return failure.message.isNotEmpty ? failure.message : 'Terjadi kesalahan';
  }
}
