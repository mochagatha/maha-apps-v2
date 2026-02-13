import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';

/// Centralized registry for all settings menu items
/// This makes it easy to maintain menu configurations in one place
class SettingsMenuRegistry {
  /// Private ructor to prevent instantiation
  SettingsMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    'PENGATURAN/ABSENSI': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI',
      titleKey: 'settingsAbsensi',
      iconPath: 'assets/icons/settings/absensi.png',
      routePath: AppRoutes.settingsAbsensi.path,
      order: 1,
    ),
    'PENGATURAN/FORMAT_DAN_DRAF': SubMenuConfig(
      code: 'PENGATURAN/FORMAT_DAN_DRAF',
      titleKey: 'settingsFormatDanDraf',
      iconPath: 'assets/icons/settings/format_dan_draf.png',
      routePath: AppRoutes.settingsFormatDanDraf.path,
      order: 2,
    ),
    'PENGATURAN/PENEMPATAN_KERJA': SubMenuConfig(
      code: 'PENGATURAN/PENEMPATAN_KERJA',
      titleKey: 'settingsPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: AppRoutes.settingsPenempatanKerja.path,
      order: 3,
    ),
    'PENGATURAN/LIBUR': SubMenuConfig(
      code: 'PENGATURAN/LIBUR',
      titleKey: 'settingsLibur',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: AppRoutes.settingsLibur.path,
      order: 4,
    ),
    'PENGATURAN/PENGATURAN_LEMBUR': SubMenuConfig(
      code: 'PENGATURAN/PENGATURAN_LEMBUR',
      titleKey: 'settingsLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: AppRoutes.settingsLembur.path,
      order: 5,
    ),
    'PENGATURAN/TINDAKAN_KARYAWAN': SubMenuConfig(
      code: 'PENGATURAN/TINDAKAN_KARYAWAN',
      titleKey: 'settingsTindakanKaryawan',
      iconPath: 'assets/images/icon/tindakan_karyawan.svg',
      routePath: AppRoutes.settingsTindakanKaryawan.path,
      order: 6,
    ),
    'PENGATURAN/AKSES_LAYAR': SubMenuConfig(
      code: 'PENGATURAN/AKSES_LAYAR',
      titleKey: 'settingsAksesLayar',
      iconPath: 'assets/images/icon/akses_layar.svg',
      routePath: AppRoutes.settingsAksesLayar.path,
      order: 7,
    ),
    'PENGATURAN/HAK_AKSES_MENU': SubMenuConfig(
      code: 'PENGATURAN/HAK_AKSES_MENU',
      titleKey: 'settingsHakAksesMenu',
      iconPath: 'assets/images/icon/hak_akses_menu.svg',
      routePath: AppRoutes.employeeSelection.path,
      order: 8,
    ),
    'PENGATURAN/EMAIL': SubMenuConfig(
      code: 'PENGATURAN/EMAIL',
      titleKey: 'settingsEmail',
      iconPath: 'assets/icons/settings/email.png',
      routePath: AppRoutes.settingsEmail.path,
      order: 9,
    ),
    'PENGATURAN/WHATSAPP': SubMenuConfig(
      code: 'PENGATURAN/WHATSAPP',
      titleKey: 'settingsWhatsapp',
      iconPath: 'assets/icons/settings/whatsapp.png',
      routePath: AppRoutes.settingsWhatsapp.path,
      order: 10,
    ),
    'PENGATURAN/ALUR_OPERASIONAL': SubMenuConfig(
      code: 'PENGATURAN/ALUR_OPERASIONAL',
      titleKey: 'settingsAlurOperasional',
      iconPath: 'assets/icons/settings/alur_operasional.png',
      routePath: AppRoutes.settingsAlurOperasional.path,
      order: 11,
    ),
    'PENGATURAN/PELCAKAN_JAM_KERJA': SubMenuConfig(
      code: 'PENGATURAN/PELCAKAN_JAM_KERJA',
      titleKey: 'settingsPelacakanJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: AppRoutes.settingsPelacakanJamKerja.path,
      order: 12,
    ),
    'PENGATURAN/STRUKTUR_ORGANISASI': SubMenuConfig(
      code: 'PENGATURAN/STRUKTUR_ORGANISASI',
      titleKey: 'settingsStrukturOrganisasi',
      iconPath: 'assets/images/icon/struktur_organisasi.svg',
      routePath: AppRoutes.organizationalStructure.path,
      order: 13,
    ),
    'PENGATURAN/KPI': SubMenuConfig(
      code: 'PENGATURAN/KPI',
      titleKey: 'settingsKpi',
      iconPath: 'assets/images/icon/setting_kpi.svg',
      routePath: AppRoutes.settingsKpi.path,
      order: 14,
    ),
    'PENGATURAN/BAHASA': SubMenuConfig(
      code: 'PENGATURAN/BAHASA',
      titleKey: 'settingsBahasa',
      iconPath: 'assets/images/icon/setting_language.svg',
      hasCustomAction: true, // Shows language dialog instead of navigation
      order: 15,
    ),
    'PENGATURAN/NOTIFIKASI': SubMenuConfig(
      code: 'PENGATURAN/NOTIFIKASI',
      titleKey: 'settingsNotifikasi',
      iconPath: 'assets/icons/settings/notifikasi.png',
      routePath: AppRoutes.settingsNotifikasi.path,
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
