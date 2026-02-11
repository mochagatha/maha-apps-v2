import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';

/// Centralized registry for all settings menu items
/// This makes it easy to maintain menu configurations in one place
class SettingsMenuRegistry {
  /// Private constructor to prevent instantiation
  SettingsMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    'PENGATURAN/ABSENSI': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI',
      titleKey: 'settingsAbsensi',
      iconPath: 'assets/icons/settings/absensi.png',
      routePath: RoutePaths.settingsAbsensi,
      order: 1,
    ),
    'PENGATURAN/FORMAT_DAN_DRAF': const SubMenuConfig(
      code: 'PENGATURAN/FORMAT_DAN_DRAF',
      titleKey: 'settingsFormatDanDraf',
      iconPath: 'assets/icons/settings/format_dan_draf.png',
      routePath: RoutePaths.settingsFormatDanDraf,
      order: 2,
    ),
    'PENGATURAN/PENEMPATAN_KERJA': const SubMenuConfig(
      code: 'PENGATURAN/PENEMPATAN_KERJA',
      titleKey: 'settingsPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: RoutePaths.settingsPenempatanKerja,
      order: 3,
    ),
    'PENGATURAN/LIBUR': const SubMenuConfig(
      code: 'PENGATURAN/LIBUR',
      titleKey: 'settingsLibur',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: RoutePaths.settingsLibur,
      order: 4,
    ),
    'PENGATURAN/PENGATURAN_LEMBUR': const SubMenuConfig(
      code: 'PENGATURAN/PENGATURAN_LEMBUR',
      titleKey: 'settingsLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: RoutePaths.settingsLembur,
      order: 5,
    ),
    'PENGATURAN/TINDAKAN_KARYAWAN': const SubMenuConfig(
      code: 'PENGATURAN/TINDAKAN_KARYAWAN',
      titleKey: 'settingsTindakanKaryawan',
      iconPath: 'assets/images/icon/tindakan_karyawan.svg',
      routePath: RoutePaths.settingsTindakanKaryawan,
      order: 6,
    ),
    'PENGATURAN/AKSES_LAYAR': const SubMenuConfig(
      code: 'PENGATURAN/AKSES_LAYAR',
      titleKey: 'settingsAksesLayar',
      iconPath: 'assets/images/icon/akses_layar.svg',
      routePath: RoutePaths.settingsAksesLayar,
      order: 7,
    ),
    'PENGATURAN/HAK_AKSES_MENU': const SubMenuConfig(
      code: 'PENGATURAN/HAK_AKSES_MENU',
      titleKey: 'settingsHakAksesMenu',
      iconPath: 'assets/images/icon/hak_akses_menu.svg',
      routePath: RoutePaths.employeeSelection,
      order: 8,
    ),
    'PENGATURAN/EMAIL': const SubMenuConfig(
      code: 'PENGATURAN/EMAIL',
      titleKey: 'settingsEmail',
      iconPath: 'assets/icons/settings/email.png',
      routePath: RoutePaths.settingsEmail,
      order: 9,
    ),
    'PENGATURAN/WHATSAPP': const SubMenuConfig(
      code: 'PENGATURAN/WHATSAPP',
      titleKey: 'settingsWhatsapp',
      iconPath: 'assets/icons/settings/whatsapp.png',
      routePath: RoutePaths.settingsWhatsapp,
      order: 10,
    ),
    'PENGATURAN/ALUR_OPERASIONAL': const SubMenuConfig(
      code: 'PENGATURAN/ALUR_OPERASIONAL',
      titleKey: 'settingsAlurOperasional',
      iconPath: 'assets/icons/settings/alur_operasional.png',
      routePath: RoutePaths.settingsAlurOperasional,
      order: 11,
    ),
    'PENGATURAN/PELCAKAN_JAM_KERJA': const SubMenuConfig(
      code: 'PENGATURAN/PELCAKAN_JAM_KERJA',
      titleKey: 'settingsPelacakanJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: RoutePaths.settingsPelacakanJamKerja,
      order: 12,
    ),
    'PENGATURAN/STRUKTUR_ORGANISASI': const SubMenuConfig(
      code: 'PENGATURAN/STRUKTUR_ORGANISASI',
      titleKey: 'settingsStrukturOrganisasi',
      iconPath: 'assets/images/icon/struktur_organisasi.svg',
      routePath: RoutePaths.organizationalStructure,
      order: 13,
    ),
    'PENGATURAN/KPI': const SubMenuConfig(
      code: 'PENGATURAN/KPI',
      titleKey: 'settingsKpi',
      iconPath: 'assets/images/icon/setting_kpi.svg',
      routePath: RoutePaths.settingsKpi,
      order: 14,
    ),
    'PENGATURAN/BAHASA': const SubMenuConfig(
      code: 'PENGATURAN/BAHASA',
      titleKey: 'settingsBahasa',
      iconPath: 'assets/images/icon/setting_language.svg',
      hasCustomAction: true, // Shows language dialog instead of navigation
      order: 15,
    ),
    'PENGATURAN/NOTIFIKASI': const SubMenuConfig(
      code: 'PENGATURAN/NOTIFIKASI',
      titleKey: 'settingsNotifikasi',
      iconPath: 'assets/icons/settings/notifikasi.png',
      routePath: RoutePaths.settingsNotifikasi,
      order: 16,
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
