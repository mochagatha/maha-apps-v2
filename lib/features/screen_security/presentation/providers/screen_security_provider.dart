import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:screen_protector/screen_protector.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/screen_security_entity.dart';
import '../../domain/usecases/get_screen_security_settings.dart';

enum ScreenSecurityStatus { initial, loading, loaded, error }

class ScreenSecurityProvider extends ChangeNotifier {
  final GetScreenSecuritySettings getScreenSecuritySettings;

  ScreenSecurityProvider({required this.getScreenSecuritySettings});

  ScreenSecurityStatus _status = ScreenSecurityStatus.initial;
  ScreenSecurityEntity? _securitySettings;
  String _errorMessage = '';
  bool _isSecurityEnabled = false;

  ScreenSecurityStatus get status => _status;
  ScreenSecurityEntity? get securitySettings => _securitySettings;
  String get errorMessage => _errorMessage;
  bool get isSecurityEnabled => _isSecurityEnabled;

  Future<void> fetchAndApplySecuritySettings({
    required String type,
    required int employeeWorkerId,
  }) async {
    _status = ScreenSecurityStatus.loading;
    notifyListeners();

    if (kDebugMode) {
      print('🔒 Fetching screen security settings for employee: $employeeWorkerId, type: $type');
    }

    final result = await getScreenSecuritySettings(
      ScreenSecurityParams(type: type, employeeWorkerId: employeeWorkerId),
    );

    result.fold(
      (failure) {
        _status = ScreenSecurityStatus.error;
        _errorMessage = _mapFailureToMessage(failure);
        if (kDebugMode) {
          print('❌ Screen security fetch failed: $_errorMessage');
        }
        notifyListeners();
      },
      (settings) async {
        _securitySettings = settings;
        _status = ScreenSecurityStatus.loaded;

        if (kDebugMode) {
          print('✅ Screen security settings loaded:');
          print('   - is_record: ${settings.isRecord}');
          print('   - is_catch: ${settings.isCatch}');
        }

        // Apply security settings
        await _applySecuritySettings(settings);

        notifyListeners();
      },
    );
  }

  Future<void> _applySecuritySettings(ScreenSecurityEntity settings) async {
    // Only apply on Android and iOS platforms
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      try {
        // LOGIKA TERBALIK:
        // is_catch = true  → screenshot BISA ditangkap (DIPERBOLEHKAN) → JANGAN block
        // is_catch = false → screenshot TIDAK bisa ditangkap (DIBLOKIR) → HARUS block
        // is_record = true  → recording DIPERBOLEHKAN → JANGAN block
        // is_record = false → recording DIBLOKIR → HARUS block

        final shouldBlockScreenshot = !settings.isCatch; // DIBALIK!
        // Note: Screen recording prevention is included with screenshot protection
        // on Android (FLAG_SECURE blocks both)

        if (kDebugMode) {
          print('🛡️ Applying security settings:');
          print('   - API is_catch: ${settings.isCatch}');
          print('   - API is_record: ${settings.isRecord}');
          print('   - shouldBlockScreenshot: $shouldBlockScreenshot');
        }

        if (shouldBlockScreenshot) {
          // Prevent screenshots (is_catch = false)
          await ScreenProtector.protectDataLeakageOn();
          _isSecurityEnabled = true;
          if (kDebugMode) {
            print('🔒 Screenshot protection ENABLED (is_catch=false)');
          }
        } else {
          // Allow screenshots (is_catch = true)
          await ScreenProtector.protectDataLeakageOff();
          _isSecurityEnabled = false;
          if (kDebugMode) {
            print('🔓 Screenshot protection DISABLED (is_catch=true)');
          }
        }

        // Note: Screen recording prevention is handled differently
        // on Android (FLAG_SECURE also blocks recording)
        // on iOS, recording prevention is limited by OS
      } catch (e) {
        if (kDebugMode) {
          print('❌ Error applying security settings: $e');
        }
      }
    } else {
      if (kDebugMode) {
        print('⚠️ Screen security not supported on this platform (Web)');
      }
    }
  }

  Future<void> disableSecurity() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      try {
        await ScreenProtector.protectDataLeakageOff();
        _isSecurityEnabled = false;
        notifyListeners();
      } catch (e) {
        if (kDebugMode) {
          print('Error disabling security: $e');
        }
      }
    }
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is NetworkFailure) {
      return failure.message;
    } else {
      return 'Unexpected error';
    }
  }

  @override
  void dispose() {
    // Clean up when provider is disposed
    super.dispose();
  }
}
