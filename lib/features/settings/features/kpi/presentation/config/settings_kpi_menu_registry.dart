import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';

/// Centralized registry for all settings absensi submenu items
/// This makes it easy to maintain menu configurations in one place
class SettingsKpiMenuRegistry {
  /// Private ructor to prevent instantiation
  SettingsKpiMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    'PENGATURAN/KPI/TARGET_POINT': SubMenuConfig(
      code: 'PENGATURAN/KPI/TARGET_POINT',
      titleKey: 'settingsKpiTargetPoint',
      iconPath: 'assets/icons/settings/target_point.svg',
      routePath: AppRoutes.settingsKpiTargetPoint.path,
      order: 1,
    ),
    'PENGATURAN/KPI/PENILAIAN_KINERJA': SubMenuConfig(
      code: 'PENGATURAN/KPI/PENILAIAN_KINERJA',
      titleKey: 'settingsKpiPenilaianKinerja',
      iconPath: 'assets/icons/settings/penilaian_kinerja.svg',
      routePath: AppRoutes.settingsKpiPenilaianKinerja.path,
      order: 2,
    ),
    'PENGATURAN/KPI/UBAH_PERIODE_SURAT': SubMenuConfig(
      code: 'PENGATURAN/KPI/UBAH_PERIODE_SURAT',
      titleKey: 'settingsKpiUbahPeriodeSurat',
      iconPath: 'assets/icons/settings/ubah_periode_surat.svg',
      routePath: AppRoutes.settingsKpiUbahPeriodeSurat.path,
      order: 3,
    ),
    'PENGATURAN/KPI/PENGATURAN_AKTIVASI_POINT': SubMenuConfig(
      code: 'PENGATURAN/KPI/PENGATURAN_AKTIVASI_POINT',
      titleKey: 'settingsKpiPengaturanAktivasiPoint',
      iconPath: 'assets/icons/settings/pengaturan_aktivasi_point.svg',
      routePath: AppRoutes.settingsKpiPengaturanAktivasiPoint.path,
      order: 4,
    ),
  };

  /// Get configuration for a specific menu code
  /// Returns null if not found
  static SubMenuConfig? getConfig(String code) {
    return _registry[code];
  }

  /// Check if menu code exists in registry
  static bool hasConfig(String code) {
    return _registry.containsKey(code);
  }
}
