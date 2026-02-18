import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/utils/localization_extension.dart';

class RecruitmentMenuMapper {
  /// Get menu details (icon, route) based on menu ID
  static Map<String, dynamic> getMenuDetails(String id) {
    final defaultMenu = {
      'icon': 'assets/images/icon/logo.png', // Default icon
      'route': null,
      'isAsset': true,
    };
    final menus = {
      AppConstants.menu.subRekrutmen.verifikasiData: {
        'icon': 'assets/images/icon/icon_verifikasi_data.svg',
        'route': AppRoutes.verificationData.path,
        'isAsset': true,
      },
      AppConstants.menu.subRekrutmen.perjanjianKerja: {
        'icon': 'assets/images/icon/icon_verifikasi_data_hrManager.svg',
        'route': AppRoutes.employeeVerification.path,
        'isAsset': true,
      },
      AppConstants.menu.subRekrutmen.aktivasiBpjs: {
        'icon': 'assets/images/icon/aktivasi_bpjs.svg',
        'route': null, // Will be implemented later
        'isAsset': true,
      },
      AppConstants.menu.subRekrutmen.kodePerusahaan: {
        'icon': 'assets/images/icon/icon_verifikasi_kode.svg',
        'route': AppRoutes.companyCode.path,
        'isAsset': true,
      },
      AppConstants.menu.subRekrutmen.eMatrai: {
        'icon': 'assets/images/icon/ic_e_matrai.svg',
        'route': AppRoutes.recruitmentEMatrai.path,
        'isAsset': true,
      },
    };

    return menus[id] ?? defaultMenu;
  }

  /// Get localized menu label
  static String getMenuLabel(BuildContext context, String id) {
    final defaultLabel = id
        .split('/')
        .last
        .replaceAll('_', ' ')
        .toLowerCase()
        .split(' ')
        .map((word) {
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
    final labels = {
      AppConstants.menu.subRekrutmen.verifikasiData:
          context.l10n.menuVerifikasiData,
      AppConstants.menu.subRekrutmen.perjanjianKerja:
          context.l10n.menuPerjanjianKerja,
      AppConstants.menu.subRekrutmen.aktivasiBpjs:
          context.l10n.menuAktivasiBpjs,
      AppConstants.menu.subRekrutmen.kodePerusahaan:
          context.l10n.menuKodePerusahaan,
      AppConstants.menu.subRekrutmen.eMatrai: "E-Matrai",
    };
    
    return labels[id] ?? defaultLabel;
  }

  /// Check if menu has an active route
  static bool hasRoute(String id) {
    final details = getMenuDetails(id);
    return details['route'] != null;
  }

  /// Get route for menu
  static String? getRoute(String id) {
    final details = getMenuDetails(id);
    return details['route'] as String?;
  }

  /// Get icon path for menu
  static String getIcon(String id) {
    final details = getMenuDetails(id);
    return details['icon'] as String;
  }
}
