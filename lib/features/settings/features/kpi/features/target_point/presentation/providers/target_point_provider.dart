import 'package:flutter/foundation.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../../domain/entities/target_point_indicator.dart';
import '../../domain/usecases/get_target_point_indicators.dart';
import '../../domain/usecases/update_target_point_indicator.dart';

/// Provider for Target Point feature
/// Manages state for target point configuration
class TargetPointProvider extends ChangeNotifier {
  final GetTargetPointIndicators getTargetPointIndicatorsUseCase;
  final UpdateTargetPointIndicator updateTargetPointIndicatorUseCase;

  TargetPointProvider({
    required this.getTargetPointIndicatorsUseCase,
    required this.updateTargetPointIndicatorUseCase,
  });

  // State
  TargetPointIndicator? _indicator;
  int _totalGaji = 1000;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  TargetPointIndicator? get indicator => _indicator;
  int get totalGaji => _totalGaji;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Load target point indicators from API
  Future<void> loadTargetPointIndicators() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final result = await getTargetPointIndicatorsUseCase(const NoParams());

    result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
      },
      (indicators) {
        // Find the indicator with indicator_name "Total Gaji"
        if (indicators.isNotEmpty) {
          _indicator = indicators.firstWhere(
            (indicator) => indicator.indicatorName == 'Total Gaji',
            orElse: () => indicators.first,
          );
          _totalGaji = _indicator!.value;
        }
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  /// Update total gaji value locally
  void updateTotalGaji(int value) {
    _totalGaji = value;
    notifyListeners();
  }

  /// Reset total gaji to original loaded value
  void reset() {
    if (_indicator != null) {
      _totalGaji = _indicator!.value;
    } else {
      _totalGaji = 1000;
    }
    _errorMessage = null;
    notifyListeners();
  }

  /// Apply/save the target point changes
  Future<bool> applyChanges() async {
    if (_indicator == null) {
      _errorMessage = 'No indicator data loaded. Please try again.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final params = UpdateTargetPointParams(
      id: _indicator!.id,
      value: _totalGaji,
    );

    final result = await updateTargetPointIndicatorUseCase(params);

    return result.fold(
      (failure) {
        _errorMessage = _mapFailureToMessage(failure);
        _isLoading = false;
        notifyListeners();
        return false;
      },
      (_) {
        // Update local indicator with new value
        _indicator = TargetPointIndicator(
          id: _indicator!.id,
          name: _indicator!.name,
          indicatorName: _indicator!.indicatorName,
          operator: _indicator!.operator,
          value: _totalGaji,
          typeValue: _indicator!.typeValue,
          typeIndicator: _indicator!.typeIndicator,
        );
        _isLoading = false;
        notifyListeners();
        return true;
      },
    );
  }

  /// Map failure to user-friendly message
  String _mapFailureToMessage(dynamic failure) {
    return failure.toString().replaceAll('ServerFailure: ', '');
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
