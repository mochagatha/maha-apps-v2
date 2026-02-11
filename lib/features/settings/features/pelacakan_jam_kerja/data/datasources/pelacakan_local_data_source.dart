import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/tracking_settings_model.dart';

abstract class PelacakanLocalDataSource {
  Future<TrackingSettingsModel?> getCachedSettings(String employeeType);
  Future<void> cacheSettings(TrackingSettingsModel settings);
  Future<void> clearCache();
}

class PelacakanLocalDataSourceImpl implements PelacakanLocalDataSource {
  final SharedPreferences sharedPreferences;

  PelacakanLocalDataSourceImpl({required this.sharedPreferences});

  static const String _settingsKey = 'CACHED_TRACKING_SETTINGS_';

  @override
  Future<TrackingSettingsModel?> getCachedSettings(String employeeType) async {
    final jsonString = sharedPreferences.getString('$_settingsKey$employeeType');
    if (jsonString != null) {
      return TrackingSettingsModel.fromJson(jsonDecode(jsonString));
    }
    return null;
  }

  @override
  Future<void> cacheSettings(TrackingSettingsModel settings) async {
    await sharedPreferences.setString(
      '$_settingsKey${settings.employeeType}',
      jsonEncode(settings.toJson()),
    );
  }

  @override
  Future<void> clearCache() async {
    final keys = sharedPreferences.getKeys();
    for (final key in keys) {
      if (key.startsWith(_settingsKey)) {
        await sharedPreferences.remove(key);
      }
    }
  }
}
