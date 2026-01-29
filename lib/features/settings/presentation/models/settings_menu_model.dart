import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/config/menu_config.dart';
import 'package:maha_apps_v2/core/router/route_paths.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_item.dart';

/// Settings menu model containing all available settings menu items
class SettingsMenuModel {
  /// Get all settings menu items
  /// Get all settings menu items
  static List<SettingsMenuItem> getAllSettingsMenu(BuildContext context) {
    return [
      SettingsMenuItem(
        id: MenuConfig.pengaturanPenempatanKerja,
        icon: 'assets/images/icon/penempatan_kerja_icon.svg',
        text: context.l10n.menuPenempatanKerja,
        count: 0,
        route: RoutePaths.settingsPenempatanKerja,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanLibur,
        icon: 'assets/images/icon/hari_libur.svg',
        text: context.l10n.menuHariLibur,
        count: 0,
        route: RoutePaths.settingsLibur,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanHirarkiOffice,
        icon: 'assets/images/icon/penempatan_kerja_icon.svg',
        text: context.l10n.menuHirarkiOffice,
        count: 0,
        route: RoutePaths.settingsHirarkiOffice,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanPengaturanLembur,
        icon: 'assets/images/icon/lembur.svg',
        text: context.l10n.menuLembur,
        count: 0,
        route: RoutePaths.settingsLembur,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanTindakanKaryawan,
        icon: 'assets/images/icon/tindakan_karyawan.svg',
        text: context.l10n.menuTindakanKaryawan,
        count: 0,
        route: RoutePaths.settingsTindakanKaryawan,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanBpjs,
        icon: 'assets/images/icon/pengaturan_lembur.svg',
        text: context.l10n.menuBpjs,
        count: 0,
        route: RoutePaths.settingsBpjs,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanPph21,
        icon: 'assets/images/icon/pengaturan_lembur.svg',
        text: context.l10n.menuPph21,
        count: 0,
        route: RoutePaths.settingsPph21,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanJamKerja,
        icon: 'assets/images/icon/jam_kerja.svg',
        text: context.l10n.menuJamKerja,
        count: 0,
        route: RoutePaths.settingsJamKerja,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanFormatDanDraf,
        icon: 'assets/images/icon/format_and_draf.svg',
        text: context.l10n.menuFormatDanDraf,
        count: 0,
        route: RoutePaths.settingsFormatDanDraf,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanAksesLayar,
        icon: 'assets/images/icon/akses_layar.svg',
        text: context.l10n.menuAksesLayar,
        count: 0,
        route: RoutePaths.settingsAksesLayar,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanHakAksesMenu,
        icon: 'assets/images/icon/hak_akses_menu.svg',
        text: context.l10n.menuHakAksesMenu,
        count: 0,
        route: RoutePaths.settingsHakAksesMenu,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanPelcakanJamKerja,
        icon: 'assets/images/icon/jam_kerja.svg',
        text: context.l10n.menuPelacakanJamKerja,
        count: 0,
        route: RoutePaths.settingsPelacakanJamKerja,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanStrukturOrganisasi,
        icon: 'assets/images/icon/struktur_organisasi.svg',
        text: context.l10n.menuStrukturOrganisasi,
        count: 0,
        route: RoutePaths.organizationalStructure,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanKpi,
        icon: 'assets/images/icon/setting_kpi.svg',
        text: context.l10n.menuKpi,
        count: 0,
        route: RoutePaths.settingsKpi,
      ),
      SettingsMenuItem(
        id: MenuConfig.pengaturanBahasa,
        icon: 'assets/images/icon/setting_language.svg',
        text: context.l10n.changeLanguage,
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
