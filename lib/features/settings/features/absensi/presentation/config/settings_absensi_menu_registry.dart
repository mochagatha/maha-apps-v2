import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';

/// Centralized registry for all settings absensi submenu items
/// This makes it easy to maintain menu configurations in one place
class SettingsAbsensiMenuRegistry {
  /// Private constructor to prevent instantiation
  SettingsAbsensiMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    'PENGATURAN/ABSENSI/PENEMPATAN_KERJA': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PENEMPATAN_KERJA',
      titleKey: 'settingsAbsensiPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: RoutePaths.settingsAbsensiPenempatanKerja,
      order: 1,
    ),
    'PENGATURAN/ABSENSI/ZONASI': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/ZONASI',
      titleKey: 'settingsAbsensiZonasi',
      iconPath: 'assets/images/icon/branch_location.svg',
      routePath: RoutePaths.settingsAbsensiZonasi,
      order: 2,
    ),
    'PENGATURAN/ABSENSI/JAM_KERJA': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/JAM_KERJA',
      titleKey: 'settingsAbsensiJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: RoutePaths.settingsAbsensiJamKerja,
      order: 3,
    ),
    'PENGATURAN/ABSENSI/KARYAWAN': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/KARYAWAN',
      titleKey: 'settingsAbsensiKaryawan',
      iconPath: 'assets/icons/settings/karyawan.png',
      routePath: RoutePaths.settingsAbsensiKaryawan,
      order: 4,
    ),
    'PENGATURAN/ABSENSI/PEKERJA_HARIAN': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PEKERJA_HARIAN',
      titleKey: 'settingsAbsensiPekerjaHarian',
      iconPath: 'assets/icons/settings/pekerja_harian.png',
      routePath: RoutePaths.settingsAbsensiPekerjaHarian,
      order: 5,
    ),
    'PENGATURAN/ABSENSI/HARI_LIBUR_CUTI_BERSAMA': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/HARI_LIBUR_CUTI_BERSAMA',
      titleKey: 'settingsAbsensiHariLiburCutiBersama',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: RoutePaths.settingsAbsensiHariLiburCuti,
      order: 6,
    ),
    'PENGATURAN/ABSENSI/LEMBUR': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/LEMBUR',
      titleKey: 'settingsAbsensiLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: RoutePaths.settingsAbsensiLembur,
      order: 7,
    ),
    'PENGATURAN/ABSENSI/ABSEN_DIMANA_SAJA': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/ABSEN_DIMANA_SAJA',
      titleKey: 'settingsAbsensiAbsenDimanaSaja',
      iconPath: 'assets/images/icon/attendance_anywhere.svg',
      routePath: RoutePaths.settingsAbsensiAbsenDimanaSaja,
      order: 8,
    ),
    'PENGATURAN/ABSENSI/PERBAIKKAN_KEHADIRAN': const SubMenuConfig(
      code: 'PENGATURAN/ABSENSI/PERBAIKKAN_KEHADIRAN',
      titleKey: 'settingsAbsensiPerbaikanKehadiran',
      iconPath: 'assets/images/icon/rekakehadiran.svg',
      routePath: RoutePaths.settingsAbsensiPerbaikanKehadiran,
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
