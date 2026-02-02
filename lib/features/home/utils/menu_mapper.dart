import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/config/menu_config.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';

/// Enhanced Menu Mapper using centralized MenuConfig
/// Provides icon, route, and label mapping for all menu items
class MenuMapper {
  // Menu codes are now centralized in MenuConfig
  // For backward compatibility, expose them here as well
  static const String absensi = MenuConfig.absensi;
  static const String mengamati = MenuConfig.mengamati;
  static const String persetujuan = MenuConfig.persetujuan;
  static const String rencanaKerja = MenuConfig.rencanaKerja;
  static const String permintaan = MenuConfig.permintaan;
  static const String tugas = MenuConfig.tugas;
  static const String pengajuan = MenuConfig.pengajuan;
  static const String administrasi = MenuConfig.administrasi;
  static const String arsip = MenuConfig.arsip;
  static const String dataAbsensi = MenuConfig.dataAbsensi;
  static const String dataKaryawan = MenuConfig.dataKaryawan;
  static const String proyek = MenuConfig.proyek;
  static const String aduan = MenuConfig.aduan;
  static const String dataPayroll = MenuConfig.dataPayroll;
  static const String kasir = MenuConfig.kasir;
  static const String akuntansi = MenuConfig.akuntansi;
  static const String rekrutment = MenuConfig.rekrutment;
  static const String kpi = MenuConfig.kpi;
  static const String pengaturan = MenuConfig.pengaturan;
  static const String updateKontrak = MenuConfig.updateKontrak;

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
    switch (menuCode) {
      // Main Menus
      case MenuConfig.absensi:
        return context.l10n.menuAbsensi;
      case MenuConfig.mengamati:
        return context.l10n.menuMengamati;
      case MenuConfig.persetujuan:
        return context.l10n.menuPersetujuan;
      case MenuConfig.rencanaKerja:
        return context.l10n.menuRencanaKerja;
      case MenuConfig.permintaan:
        return context.l10n.menuPermintaan;
      case MenuConfig.tugas:
        return context.l10n.menuTugas;
      case MenuConfig.pengajuan:
        return context.l10n.menuPengajuan;
      case MenuConfig.administrasi:
        return context.l10n.menuAdministrasi;
      case MenuConfig.arsip:
        return context.l10n.menuArsip;
      case MenuConfig.dataAbsensi:
        return context.l10n.menuDataAbsensi;
      case MenuConfig.dataKaryawan:
        return context.l10n.menuDataKaryawan;
      case MenuConfig.proyek:
        return context.l10n.menuProyek;
      case MenuConfig.aduan:
        return context.l10n.menuAduan;
      case MenuConfig.dataPayroll:
        return context.l10n.menuDataPayroll;
      case MenuConfig.kasir:
        return context.l10n.menuKasir;
      case MenuConfig.akuntansi:
        return context.l10n.menuAkuntansi;
      case MenuConfig.rekrutment:
        return context.l10n.menuRekrutmen;
      case MenuConfig.kpi:
        return context.l10n.menuKpi;
      case MenuConfig.pengaturan:
        return context.l10n.menuPengaturan;
      case MenuConfig.updateKontrak:
        return context.l10n.menuUpdateKontrak;
      default:
        return null;
    }
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

