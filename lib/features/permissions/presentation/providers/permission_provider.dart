import 'package:flutter/material.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/check_permissions_status.dart';
import '../../domain/usecases/request_permissions.dart';
import '../../domain/usecases/open_settings.dart';
import '../../domain/usecases/is_permission_permanently_denied.dart';
import '../../domain/usecases/get_denied_permissions_detail.dart';

enum PermissionState { initial, granted, denied, permanentlyDenied }

class PermissionProvider extends ChangeNotifier {
  final CheckPermissionsStatus checkPermissionsStatus;
  final RequestPermissions requestPermissionsUseCase;
  final OpenSettings openSettingsUseCase;
  final IsPermissionPermanentlyDenied isPermissionPermanentlyDeniedUseCase;
  final GetDeniedPermissionsDetail getDeniedPermissionsDetailUseCase;

  PermissionState _state = PermissionState.initial;
  PermissionState get state => _state;

  bool _isChecking = false;
  bool get isChecking => _isChecking;

  Map<String, bool> _deniedPermissions = {};
  Map<String, bool> get deniedPermissions => _deniedPermissions;

  PermissionProvider({
    required this.checkPermissionsStatus,
    required this.requestPermissionsUseCase,
    required this.openSettingsUseCase,
    required this.isPermissionPermanentlyDeniedUseCase,
    required this.getDeniedPermissionsDetailUseCase,
  });

  Future<void> checkPermissions() async {
    _isChecking = true;
    notifyListeners();

    final result = await checkPermissionsStatus(NoParams());

    result.fold(
      (failure) {
        _state = PermissionState.denied;
        _isChecking = false;
        notifyListeners();
      },
      (isGranted) {
        _state = isGranted ? PermissionState.granted : PermissionState.denied;
        _isChecking = false;
        notifyListeners();
      },
    );
  }

  Future<void> requestPermissions() async {
    // First check if permanently denied
    final permanentlyDeniedResult = await isPermissionPermanentlyDeniedUseCase(NoParams());

    await permanentlyDeniedResult.fold(
      (failure) async {
        // If check failed, still try to request
        _attemptRequest();
      },
      (isPermanentlyDenied) async {
        if (isPermanentlyDenied) {
          // Can't request again, set state and get details
          _state = PermissionState.permanentlyDenied;
          await _loadDeniedPermissionsDetail();
          notifyListeners();
          // DON'T automatically open settings - let UI show dialog first
        } else {
          // Can request normally
          await _attemptRequest();
        }
      },
    );
  }

  Future<void> _loadDeniedPermissionsDetail() async {
    final result = await getDeniedPermissionsDetailUseCase(NoParams());
    result.fold(
      (failure) {
        _deniedPermissions = {};
      },
      (details) {
        _deniedPermissions = details;
      },
    );
  }

  Future<void> _attemptRequest() async {
    final result = await requestPermissionsUseCase(NoParams());

    result.fold(
      (failure) {
        _state = PermissionState.denied;
        notifyListeners();
      },
      (isGranted) async {
        if (isGranted) {
          _state = PermissionState.granted;
        } else {
          // Check if now permanently denied
          final permanentlyDeniedResult = await isPermissionPermanentlyDeniedUseCase(NoParams());
          await permanentlyDeniedResult.fold(
            (failure) async {
              _state = PermissionState.denied;
            },
            (isPermanentlyDenied) async {
              if (isPermanentlyDenied) {
                _state = PermissionState.permanentlyDenied;
                await _loadDeniedPermissionsDetail();
              } else {
                _state = PermissionState.denied;
              }
            },
          );
        }
        notifyListeners();
      },
    );
  }

  Future<void> openSettings() async {
    await openSettingsUseCase(NoParams());
    // After returning from settings, we should re-check permissions.
    // However, app lifecycle might trigger a check if we listen to lifecycle events.
    // For now, manual check or user triggered check.
  }
}
