import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/core/config/sub_menu_config.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';

/// Centralized registry for all settings absensi submenu items
/// This makes it easy to maintain menu configurations in one place
class SettingsAbsensiMenuRegistry {
  /// Private constructor to prevent instantiation
  SettingsAbsensiMenuRegistry._();

  /// Map of menu code to configuration
  static final Map<String, SubMenuConfig> _registry = {
    AppConstants.menu.subPengaturan.subAbsensi.penempatanKerja: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.penempatanKerja,
      titleKey: 'settingsAbsensiPenempatanKerja',
      iconPath: 'assets/images/icon/penempatan_kerja_icon.svg',
      routePath: RoutePaths.settingsAbsensiPenempatanKerja,
      order: 1,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.zonasi: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.zonasi,
      titleKey: 'settingsAbsensiZonasi',
      iconPath: 'assets/images/icon/branch_location.svg',
      routePath: RoutePaths.settingsAbsensiZonasi,
      order: 2,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.jamKerja: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.jamKerja,
      titleKey: 'settingsAbsensiJamKerja',
      iconPath: 'assets/images/icon/jam_kerja.svg',
      routePath: RoutePaths.settingsAbsensiJamKerja,
      order: 3,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.karyawan: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.karyawan,
      titleKey: 'settingsAbsensiKaryawan',
      iconPath: 'assets/icons/settings/karyawan.png',
      routePath: RoutePaths.settingsAbsensiKaryawan,
      order: 4,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.pekerjaHarian: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.pekerjaHarian,
      titleKey: 'settingsAbsensiPekerjaHarian',
      iconPath: 'assets/icons/settings/pekerja_harian.png',
      routePath: RoutePaths.settingsAbsensiPekerjaHarian,
      order: 5,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.hariLiburCutiBersama: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.hariLiburCutiBersama,
      titleKey: 'settingsAbsensiHariLiburCutiBersama',
      iconPath: 'assets/images/icon/hari_libur.svg',
      routePath: RoutePaths.settingsAbsensiHariLiburCuti,
      order: 6,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.lembur: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.lembur,
      titleKey: 'settingsAbsensiLembur',
      iconPath: 'assets/images/icon/lembur.svg',
      routePath: RoutePaths.settingsAbsensiLembur,
      order: 7,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.absenDimanaSaja: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.absenDimanaSaja,
      titleKey: 'settingsAbsensiAbsenDimanaSaja',
      iconPath: 'assets/images/icon/attendance_anywhere.svg',
      routePath: RoutePaths.settingsAbsensiAbsenDimanaSaja,
      order: 8,
    ),
    AppConstants.menu.subPengaturan.subAbsensi.perbaikkanKehadiran: SubMenuConfig(
      code: AppConstants.menu.subPengaturan.subAbsensi.perbaikkanKehadiran,
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
