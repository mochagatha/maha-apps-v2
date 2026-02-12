import 'package:flutter/foundation.dart';

/// Model for work plan position
class WorkPlanPosition {
  final String position;
  int minPoint;
  int maxPoint;

  WorkPlanPosition({
    required this.position,
    required this.minPoint,
    required this.maxPoint,
  });

  WorkPlanPosition copyWith({
    String? position,
    int? minPoint,
    int? maxPoint,
  }) {
    return WorkPlanPosition(
      position: position ?? this.position,
      minPoint: minPoint ?? this.minPoint,
      maxPoint: maxPoint ?? this.maxPoint,
    );
  }
}

/// Provider for Performance Assessment feature
/// Manages state for performance assessment configuration
class PenilaianKinerjaProvider extends ChangeNotifier {
  // Kehadiran (Attendance) State
  int _maksimalPointAbsensi = 20;
  int _terlambat = 50;
  int _tidakAbsenPulang = 50;
  int _sakit = 100;
  int _manasikMasuk = 100;

  // Penilaian Atasan (Supervisor Assessment) State
  int _maksimalPointAtasan = 20;

  // Rencana Kerja (Work Plan) State
  List<WorkPlanPosition> _workPlanPositions = [
    WorkPlanPosition(position: 'Staf', minPoint: 5, maxPoint: 100),
    WorkPlanPosition(position: 'SPV', minPoint: 50, maxPoint: 120),
  ];

  bool _isLoading = false;
  String? _errorMessage;

  // Getters - Kehadiran
  int get maksimalPointAbsensi => _maksimalPointAbsensi;
  int get terlambat => _terlambat;
  int get tidakAbsenPulang => _tidakAbsenPulang;
  int get sakit => _sakit;
  int get manasikMasuk => _manasikMasuk;

  // Getters - Penilaian Atasan
  int get maksimalPointAtasan => _maksimalPointAtasan;

  // Getters - Rencana Kerja
  List<WorkPlanPosition> get workPlanPositions => List.unmodifiable(_workPlanPositions);

  // Getters - Common
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Update Kehadiran values
  void updateMaksimalPointAbsensi(int value) {
    _maksimalPointAbsensi = value;
    notifyListeners();
  }

  void updateTerlambat(int value) {
    _terlambat = value;
    notifyListeners();
  }

  void updateTidakAbsenPulang(int value) {
    _tidakAbsenPulang = value;
    notifyListeners();
  }

  void updateSakit(int value) {
    _sakit = value;
    notifyListeners();
  }

  void updateManasikMasuk(int value) {
    _manasikMasuk = value;
    notifyListeners();
  }

  /// Update Penilaian Atasan value
  void updateMaksimalPointAtasan(int value) {
    _maksimalPointAtasan = value;
    notifyListeners();
  }

  /// Update Work Plan Position
  void updateWorkPlanPosition(int index, {int? minPoint, int? maxPoint}) {
    if (index >= 0 && index < _workPlanPositions.length) {
      _workPlanPositions[index] = _workPlanPositions[index].copyWith(
        minPoint: minPoint,
        maxPoint: maxPoint,
      );
      notifyListeners();
    }
  }

  /// Add new work plan position
  void addWorkPlanPosition(WorkPlanPosition position) {
    _workPlanPositions.add(position);
    notifyListeners();
  }

  /// Remove work plan position
  void removeWorkPlanPosition(int index) {
    if (index >= 0 && index < _workPlanPositions.length) {
      _workPlanPositions.removeAt(index);
      notifyListeners();
    }
  }

  /// Reset all values to default
  void reset() {
    _maksimalPointAbsensi = 20;
    _terlambat = 50;
    _tidakAbsenPulang = 50;
    _sakit = 100;
    _manasikMasuk = 100;
    _maksimalPointAtasan = 20;
    _workPlanPositions = [
      WorkPlanPosition(position: 'Staf', minPoint: 5, maxPoint: 100),
      WorkPlanPosition(position: 'SPV', minPoint: 50, maxPoint: 120),
    ];
    _errorMessage = null;
    notifyListeners();
  }

  /// Apply/save the performance assessment changes
  /// This is a placeholder - will be connected to use case later
  Future<bool> applyChanges() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Call use case when data/domain layers are implemented
      // final result = await applyPerformanceAssessmentUseCase(params);
      // return result.fold(
      //   (failure) {
      //     _errorMessage = _mapFailureToMessage(failure);
      //     return false;
      //   },
      //   (success) => true,
      // );

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
