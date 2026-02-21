import 'package:flutter/material.dart';
import '../../../../../../../../core/usecases/usecase.dart';
import '../../domain/entities/punishment_setting.dart';
import '../../domain/usecases/get_punishment_setting.dart';
import '../../domain/usecases/update_punishment_setting.dart';

enum UbahPeriodeSuratStatus { initial, loading, success, error, updating }

class UbahPeriodeSuratProvider extends ChangeNotifier {
  final GetPunishmentSetting _getPunishmentSetting;
  final UpdatePunishmentSetting _updatePunishmentSetting;

  UbahPeriodeSuratProvider({
    required GetPunishmentSetting getPunishmentSetting,
    required UpdatePunishmentSetting updatePunishmentSetting,
  }) : _getPunishmentSetting = getPunishmentSetting,
       _updatePunishmentSetting = updatePunishmentSetting;

  UbahPeriodeSuratStatus _status = UbahPeriodeSuratStatus.initial;
  UbahPeriodeSuratStatus get status => _status;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  PunishmentSetting? _setting;
  PunishmentSetting? get setting => _setting;

  // Form state
  bool _isActive = false;
  bool get isActive => _isActive;

  int _selectedMonths = 1;
  int get selectedMonths => _selectedMonths;

  bool _loanPoint = false;
  bool get loanPoint => _loanPoint;

  // Track if form has changes
  bool _hasChanges = false;
  bool get hasChanges => _hasChanges;

  Future<void> loadPunishmentSetting() async {
    _status = UbahPeriodeSuratStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await _getPunishmentSetting(const NoParams());

    result.fold(
      (failure) {
        _status = UbahPeriodeSuratStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
      },
      (setting) {
        _setting = setting;
        _isActive = setting.isActive;
        _selectedMonths = setting.longPunishment;
        _loanPoint = setting.loanPoint;
        _hasChanges = false;
        _status = UbahPeriodeSuratStatus.success;
        notifyListeners();
      },
    );
  }

  void toggleActivation(bool value) {
    _isActive = value;
    _checkForChanges();
    notifyListeners();
  }

  void setSelectedMonths(int months) {
    _selectedMonths = months;
    _checkForChanges();
    notifyListeners();
  }

  void toggleLoanPoint(bool value) {
    _loanPoint = value;
    _checkForChanges();
    notifyListeners();
  }

  void _checkForChanges() {
    if (_setting != null) {
      _hasChanges =
          _isActive != _setting!.isActive ||
          _selectedMonths != _setting!.longPunishment ||
          _loanPoint != _setting!.loanPoint;
    }
  }

  void resetForm() {
    if (_setting != null) {
      _isActive = _setting!.isActive;
      _selectedMonths = _setting!.longPunishment;
      _loanPoint = _setting!.loanPoint;
      _hasChanges = false;
      notifyListeners();
    }
  }

  Future<bool> saveSetting() async {
    _status = UbahPeriodeSuratStatus.updating;
    _errorMessage = null;
    notifyListeners();

    final result = await _updatePunishmentSetting(
      UpdatePunishmentSettingParams(
        isActive: _isActive,
        longPunishment: _selectedMonths,
        loanPoint: _loanPoint,
      ),
    );

    return result.fold(
      (failure) {
        _status = UbahPeriodeSuratStatus.error;
        _errorMessage = failure.message;
        notifyListeners();
        return false;
      },
      (setting) {
        _setting = setting;
        _isActive = setting.isActive;
        _selectedMonths = setting.longPunishment;
        _loanPoint = setting.loanPoint;
        _hasChanges = false;
        _status = UbahPeriodeSuratStatus.success;
        notifyListeners();
        return true;
      },
    );
  }
}
