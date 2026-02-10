import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_config.dart';

/// Centralized registry for all settings menu items
/// This makes it easy to maintain menu configurations in one place
class SettingsMenuRegistry {
  /// Private constructor to prevent instantiation
  SettingsMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SettingsMenuConfig> _registry = {
    'PENGATURAN/ABSENSI': const SettingsMenuConfig(
      code: 'PENGATURAN/ABSENSI',
      titleKey: 'settingsAbsensi',
      iconPath: 'assets/icons/settings/absensi.png',
      routePath: RoutePaths.settingsAbsensi,
      order: 1,
    ),
    'PENGATURAN/FORMAT_DAN_DRAF': const SettingsMenuConfig(
      code: 'PENGATURAN/FORMAT_DAN_DRAF',
      titleKey: 'settingsFormatDanDraf',
      iconPath: 'assets/icons/settings/format_dan_draf.png',
      routePath: RoutePaths.settingsFormatDanDraf,
      order: 2,
    ),
    'PENGATURAN/PENEMPATAN_KERJA': const SettingsMenuConfig(
      code: 'PENGATURAN/PENEMPATAN_KERJA',
      titleKey: 'settingsPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: RoutePaths.settingsPenempatanKerja,
      order: 3,
    ),
    'PENGATURAN/LIBUR': const SettingsMenuConfig(
      code: 'PENGATURAN/LIBUR',
      titleKey: 'settingsLibur',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: RoutePaths.settingsLibur,
      order: 4,
    ),
    'PENGATURAN/PENGATURAN_LEMBUR': const SettingsMenuConfig(
      code: 'PENGATURAN/PENGATURAN_LEMBUR',
      titleKey: 'settingsLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: RoutePaths.settingsLembur,
      order: 5,
    ),
    'PENGATURAN/TINDAKAN_KARYAWAN': const SettingsMenuConfig(
      code: 'PENGATURAN/TINDAKAN_KARYAWAN',
      titleKey: 'settingsTindakanKaryawan',
      iconPath: 'assets/images/icon/tindakan_karyawan.svg',
      routePath: RoutePaths.settingsTindakanKaryawan,
      order: 6,
    ),
    'PENGATURAN/AKSES_LAYAR': const SettingsMenuConfig(
      code: 'PENGATURAN/AKSES_LAYAR',
      titleKey: 'settingsAksesLayar',
      iconPath: 'assets/images/icon/akses_layar.svg',
      routePath: RoutePaths.settingsAksesLayar,
      order: 7,
    ),
    'PENGATURAN/HAK_AKSES_MENU': const SettingsMenuConfig(
      code: 'PENGATURAN/HAK_AKSES_MENU',
      titleKey: 'settingsHakAksesMenu',
      iconPath: 'assets/images/icon/hak_akses_menu.svg',
      routePath: RoutePaths.employeeSelection,
      order: 8,
    ),
    'PENGATURAN/EMAIL': const SettingsMenuConfig(
      code: 'PENGATURAN/EMAIL',
      titleKey: 'settingsEmail',
      iconPath: 'assets/icons/settings/email.png',
      routePath: RoutePaths.settingsEmail,
      order: 9,
    ),
    'PENGATURAN/WHATSAPP': const SettingsMenuConfig(
      code: 'PENGATURAN/WHATSAPP',
      titleKey: 'settingsWhatsapp',
      iconPath: 'assets/icons/settings/whatsapp.png',
      routePath: RoutePaths.settingsWhatsapp,
      order: 10,
    ),
    'PENGATURAN/ALUR_OPERASIONAL': const SettingsMenuConfig(
      code: 'PENGATURAN/ALUR_OPERASIONAL',
      titleKey: 'settingsAlurOperasional',
      iconPath: 'assets/icons/settings/alur_operasional.png',
      routePath: RoutePaths.settingsAlurOperasional,
      order: 11,
    ),
    'PENGATURAN/PELCAKAN_JAM_KERJA': const SettingsMenuConfig(
      code: 'PENGATURAN/PELCAKAN_JAM_KERJA',
      titleKey: 'settingsPelacakanJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: RoutePaths.settingsPelacakanJamKerja,
      order: 12,
    ),
    'PENGATURAN/STRUKTUR_ORGANISASI': const SettingsMenuConfig(
      code: 'PENGATURAN/STRUKTUR_ORGANISASI',
      titleKey: 'settingsStrukturOrganisasi',
      iconPath: 'assets/images/icon/struktur_organisasi.svg',
      routePath: RoutePaths.organizationalStructure,
      order: 13,
    ),
    'PENGATURAN/KPI': const SettingsMenuConfig(
      code: 'PENGATURAN/KPI',
      titleKey: 'settingsKpi',
      iconPath: 'assets/images/icon/setting_kpi.svg',
      routePath: RoutePaths.settingsKpi,
      order: 14,
    ),
    'PENGATURAN/BAHASA': const SettingsMenuConfig(
      code: 'PENGATURAN/BAHASA',
      titleKey: 'settingsBahasa',
      iconPath: 'assets/images/icon/setting_language.svg',
      hasCustomAction: true, // Shows language dialog instead of navigation
      order: 15,
    ),
    'PENGATURAN/NOTIFIKASI': const SettingsMenuConfig(
      code: 'PENGATURAN/NOTIFIKASI',
      titleKey: 'settingsNotifikasi',
      iconPath: 'assets/icons/settings/notifikasi.png',
      routePath: RoutePaths.settingsNotifikasi,
      order: 16,
    ),
  };

  /// Get configuration for a specific menu code
  /// Returns null if not found
  static SettingsMenuConfig? getConfig(String code) {
    return _registry[code];
  }

  /// Get all registered menu configurations
  static List<SettingsMenuConfig> getAllConfigs() {
    return _registry.values.toList()..sort((a, b) => a.order.compareTo(b.order));
  }

  /// Get icon path for a menu code
  /// Returns default icon if not found
  static String getIconPath(String code) {
    return _registry[code]?.iconPath ?? 'assets/images/icon/default_menu.svg';
  }

  /// Get route path for a menu code
  /// Returns null if not found or has custom action
  static String? getRoutePath(String code) {
    final config = _registry[code];
    return config?.hasCustomAction == true ? null : config?.routePath;
  }

  /// Get l10n key for a menu code
  /// Returns the code itself if not found (fallback)
  static String getTitleKey(String code) {
    return _registry[code]?.titleKey ?? code;
  }

  /// Check if menu has custom action (e.g., dialog instead of navigation)
  static bool hasCustomAction(String code) {
    return _registry[code]?.hasCustomAction ?? false;
  }

  /// Get all menu codes
  static List<String> getAllCodes() {
    return _registry.keys.toList();
  }

  /// Check if menu code exists in registry
  static bool hasConfig(String code) {
    return _registry.containsKey(code);
  }
}
