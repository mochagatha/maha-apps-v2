import 'package:maha_apps_v2/core/config/menu_config.dart';
import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_item.dart';

/// Settings menu model containing all available settings menu items
class SettingsMenuModel {
  /// Get all settings menu items
  static List<SettingsMenuItem> getAllSettingsMenu() {
    return [
      const SettingsMenuItem(
        id: MenuConfig.pengaturanPenempatanKerja,
        icon: 'assets/images/icon/penempatan_kerja_icon.svg',
        text: 'Penempatan kerja',
        count: 0,
        route: RoutePaths.settingsPenempatanKerja,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanLibur,
        icon: 'assets/images/icon/hari_libur.svg',
        text: 'Hari Libur & Cuti Bersama',
        count: 0,
        route: RoutePaths.settingsLibur,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanHirarkiOffice,
        icon: 'assets/images/icon/penempatan_kerja_icon.svg',
        text: 'Hirarki Office',
        count: 0,
        route: RoutePaths.settingsHirarkiOffice,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanPengaturanLembur,
        icon: 'assets/images/icon/lembur.svg',
        text: 'Lembur',
        count: 0,
        route: RoutePaths.settingsLembur,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanTindakanKaryawan,
        icon: 'assets/images/icon/tindakan_karyawan.svg',
        text: 'Tindakan Karyawan',
        count: 0,
        route: RoutePaths.settingsTindakanKaryawan,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanBpjs,
        icon: 'assets/images/icon/pengaturan_lembur.svg',
        text: 'BPJS',
        count: 0,
        route: RoutePaths.settingsBpjs,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanPph21,
        icon: 'assets/images/icon/pengaturan_lembur.svg',
        text: 'PPH 21',
        count: 0,
        route: RoutePaths.settingsPph21,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanJamKerja,
        icon: 'assets/images/icon/jam_kerja.svg',
        text: 'Jam Kerja',
        count: 0,
        route: RoutePaths.settingsJamKerja,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanFormatDanDraf,
        icon: 'assets/images/icon/format_and_draf.svg',
        text: 'Format dan Draf',
        count: 0,
        route: RoutePaths.settingsFormatDanDraf,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanAksesLayar,
        icon: 'assets/images/icon/akses_layar.svg',
        text: 'Akses Layar',
        count: 0,
        route: RoutePaths.settingsAksesLayar,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanHakAksesMenu,
        icon: 'assets/images/icon/hak_akses_menu.svg',
        text: 'Hak Akses Menu',
        count: 0,
        route: RoutePaths.settingsHakAksesMenu,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanPelcakanJamKerja,
        icon: 'assets/images/icon/jam_kerja.svg',
        text: 'Pelacakan Jam Kerja',
        count: 0,
        route: RoutePaths.settingsPelacakanJamKerja,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanStrukturOrganisasi,
        icon: 'assets/images/icon/struktur_organisasi.svg',
        text: 'Struktur Organisasi',
        count: 0,
        route: RoutePaths.organizationalStructure,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanKpi,
        icon: 'assets/images/icon/setting_kpi.svg',
        text: 'Indikator Kinerja Utama (KPI)',
        count: 0,
        route: RoutePaths.settingsKpi,
      ),
      const SettingsMenuItem(
        id: MenuConfig.pengaturanBahasa,
        icon: 'assets/images/icon/setting_language.svg',
        text: 'Ubah Bahasa',
        count: 0,
        route: RoutePaths.settingsBahasa,
      ),
    ];
  }

  /// Get default menu IDs (used when API returns empty)
  static List<String> getDefaultMenuIds() {
    return [
      MenuConfig.pengaturanPenempatanKerja,
      MenuConfig.pengaturanHirarkiOffice,
      MenuConfig.pengaturanPengaturanLembur,
      MenuConfig.pengaturanBpjs,
      MenuConfig.pengaturanPph21,
      MenuConfig.pengaturanJamKerja,
      MenuConfig.pengaturanAksesLayar,
      MenuConfig.pengaturanHakAksesMenu,
      MenuConfig.pengaturanStrukturOrganisasi,
      MenuConfig.pengaturanLibur,
      MenuConfig.pengaturanTindakanKaryawan,
      MenuConfig.pengaturanFormatDanDraf,
      MenuConfig.pengaturanPelcakanJamKerja,
      MenuConfig.pengaturanKpi,
      MenuConfig.pengaturanBahasa,
    ];
  }
}
