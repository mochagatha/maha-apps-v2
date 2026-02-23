import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';

/// Centralized registry for all settings absensi submenu items
/// This makes it easy to maintain menu configurations in one place
class SettingsAbsensiMenuRegistry {
  /// Private ructor to prevent instantiation
  SettingsAbsensiMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    'PENGATURAN/ABSENSI/PENEMPATAN_KERJA': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PENEMPATAN_KERJA',
      titleKey: 'settingsAbsensiPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: AppRoutes.settingsAbsensiPenempatanKerja.path,
      order: 1,
    ),
    'PENGATURAN/ABSENSI/ZONASI': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/ZONASI',
      titleKey: 'settingsAbsensiZonasi',
      iconPath: 'assets/images/icon/branch_location.svg',
      routePath: AppRoutes.settingsAbsensiZonasi.path,
      order: 2,
    ),
    'PENGATURAN/ABSENSI/JAM_KERJA': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/JAM_KERJA',
      titleKey: 'settingsAbsensiJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: AppRoutes.settingsAbsensiJamKerja.path,
      order: 3,
    ),
    'PENGATURAN/ABSENSI/KARYAWAN': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/KARYAWAN',
      titleKey: 'settingsAbsensiKaryawan',
      iconPath: 'assets/icons/settings/karyawan.png',
      routePath: AppRoutes.settingsAbsensiKaryawan.path,
      order: 4,
    ),
    'PENGATURAN/ABSENSI/PEKERJA_HARIAN': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PEKERJA_HARIAN',
      titleKey: 'settingsAbsensiPekerjaHarian',
      iconPath: 'assets/icons/settings/pekerja_harian.png',
      routePath: AppRoutes.settingsAbsensiPekerjaHarian.path,
      order: 5,
    ),
    'PENGATURAN/ABSENSI/HARI_LIBUR_CUTI_BERSAMA': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/HARI_LIBUR_CUTI_BERSAMA',
      titleKey: 'settingsAbsensiHariLiburCutiBersama',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: AppRoutes.settingsAbsensiHariLiburCuti.path,
      order: 6,
    ),
    'PENGATURAN/ABSENSI/LEMBUR': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/LEMBUR',
      titleKey: 'settingsAbsensiLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: AppRoutes.settingsAbsensiLembur.path,
      order: 7,
    ),
    'PENGATURAN/ABSENSI/ABSEN_DIMANA_SAJA': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/ABSEN_DIMANA_SAJA',
      titleKey: 'settingsAbsensiAbsenDimanaSaja',
      iconPath: 'assets/images/icon/attendance_anywhere.svg',
      routePath: AppRoutes.settingsAbsensiAbsenDimanaSaja.path,
      order: 8,
    ),
    'PENGATURAN/ABSENSI/PERBAIKKAN_KEHADIRAN': SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PERBAIKKAN_KEHADIRAN',
      titleKey: 'settingsAbsensiPerbaikanKehadiran',
      iconPath: 'assets/images/icon/rekakehadiran.svg',
      routePath: AppRoutes.settingsAbsensiPerbaikanKehadiran.path,
      order: 9,
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
