import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/config/menu_config.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';

/// Enhanced Menu Mapper using centralized MenuConfig
/// Provides icon, route, and label mapping for all menu items
class MenuMapper {
  // Menu codes are now centralized in MenuConfig
  // For backward compatibility, expose them here as well
  static final String absensi = AppConstants.menu.absensi;
  static final String mengamati = AppConstants.menu.mengamati;
  static final String persetujuan = AppConstants.menu.persetujuan;
  static final String rencanaKerja = AppConstants.menu.rencanaKerja;
  static final String permintaan = AppConstants.menu.permintaan;
  static final String tugas = AppConstants.menu.tugas;
  static final String pengajuan = AppConstants.menu.pengajuan;
  static final String administrasi = AppConstants.menu.administrasi;
  static final String arsip = AppConstants.menu.arsip;
  static final String dataAbsensi = AppConstants.menu.dataAbsensi;
  static final String dataKaryawan = AppConstants.menu.dataKaryawan;
  static final String proyek = AppConstants.menu.proyek;
  static final String aduan = AppConstants.menu.aduan;
  static final String dataPayroll = AppConstants.menu.dataPayroll;
  static final String kasir = AppConstants.menu.kasir;
  static final String akuntansi = AppConstants.menu.akuntansi;
  static final String rekrutment = AppConstants.menu.rekrutment;
  static final String kpi = AppConstants.menu.kpi;
  static final String pengaturan = AppConstants.menu.pengaturan;
  static final String updateKontrak = AppConstants.menu.updateKontrak;

  /// Get menu details (icon, route, isAsset) for a menu code
  /// Uses centralized MenuConfig for mapping
  static Map<String, dynamic> getMenuDetails(String menuCode) {
    final icon = MenuConfig.getIconPath(menuCode);
    final route = MenuConfig.getRoute(menuCode);
    
    return {
      'icon': icon,
      'route': route,
      'isAsset': true,
    };
  }

  /// Get localized menu label
  /// Falls back to formatted menu code if no localization available
  static String getMenuLabel(BuildContext context, String menuCode) {
    // Try to get localized label
    final label = _getLocalizedLabel(context, menuCode);
    if (label != null) {
      return label;
    }

    // Fallback: format menu code to human-readable string
    return _formatMenuCode(menuCode);
  }

  /// Get localized label for menu code
  static String? _getLocalizedLabel(BuildContext context, String menuCode) {
    final labels = {
      AppConstants.menu.absensi: context.l10n.menuAbsensi,
      AppConstants.menu.mengamati: context.l10n.menuMengamati,
      AppConstants.menu.persetujuan: context.l10n.menuPersetujuan,
      AppConstants.menu.rencanaKerja: context.l10n.menuRencanaKerja,
      AppConstants.menu.permintaan: context.l10n.menuPermintaan,
      AppConstants.menu.tugas: context.l10n.menuTugas,
      AppConstants.menu.pengajuan: context.l10n.menuPengajuan,
      AppConstants.menu.administrasi: context.l10n.menuAdministrasi,
      AppConstants.menu.arsip: context.l10n.menuArsip,
      AppConstants.menu.dataAbsensi: context.l10n.menuDataAbsensi,
      AppConstants.menu.dataKaryawan: context.l10n.menuDataKaryawan,
      AppConstants.menu.proyek: context.l10n.menuProyek,
      AppConstants.menu.aduan: context.l10n.menuAduan,
      AppConstants.menu.dataPayroll: context.l10n.menuDataPayroll,
      AppConstants.menu.kasir: context.l10n.menuKasir,
      AppConstants.menu.akuntansi: context.l10n.menuAkuntansi,
      AppConstants.menu.rekrutment: context.l10n.menuRekrutmen,
      AppConstants.menu.kpi: context.l10n.menuKpi,
      AppConstants.menu.pengaturan: context.l10n.menuPengaturan,
      AppConstants.menu.updateKontrak: context.l10n.menuUpdateKontrak,
    };

    return labels[menuCode];
  }

  /// Format menu code to human-readable string
  /// Example: "RENCANA_KERJA" -> "Rencana Kerja"
  static String _formatMenuCode(String menuCode) {
    // Handle nested menu codes (e.g., "PERSETUJUAN/PENGAWASAN")
    final parts = menuCode.split('/');
    final lastPart = parts.last;
    
    return lastPart
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) => word.isNotEmpty 
            ? '${word[0].toUpperCase()}${word.substring(1)}' 
            : '')
        .join(' ');
  }

  /// Check if menu has a configured route
  static bool hasRoute(String menuCode) {
    return MenuConfig.hasRoute(menuCode);
  }

  /// Check if menu has a configured icon
  static bool hasIcon(String menuCode) {
    return MenuConfig.hasIcon(menuCode);
  }

  /// Get icon path for menu code
  static String getIconPath(String menuCode) {
    return MenuConfig.getIconPath(menuCode);
  }

  /// Get route for menu code
  static String? getRoute(String menuCode) {
    return MenuConfig.getRoute(menuCode);
  }
}

