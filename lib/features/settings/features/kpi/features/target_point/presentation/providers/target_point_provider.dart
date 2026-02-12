import 'package:flutter/foundation.dart';

/// Provider for Target Point feature
/// Manages state for target point configuration
class TargetPointProvider extends ChangeNotifier {
  // State
  int _totalGaji = 1000;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  int get totalGaji => _totalGaji;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  /// Update total gaji value
  void updateTotalGaji(int value) {
    _totalGaji = value;
    notifyListeners();
  }

  /// Reset total gaji to default value
  void reset() {
    _totalGaji = 1000;
    _errorMessage = null;
    notifyListeners();
  }

  /// Apply/save the target point changes
  /// This is a placeholder - will be connected to use case later
  Future<bool> applyChanges() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Call use case when data/domain layers are implemented
      // final result = await applyTargetPointUseCase(NoParams());
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
