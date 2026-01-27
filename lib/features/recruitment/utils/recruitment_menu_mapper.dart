import 'package:flutter/material.dart';
import '../../../core/router/route_paths.dart';

class RecruitmentMenuMapper {
  // Menu IDs
  static const String verifikasiData = 'REKRUTMENT/VERIFIKASI_DATA';
  static const String perjanjianKerja = 'REKRUTMENT/PERJANJIAN_KERJA';
  static const String aktivasiBpjs = 'REKRUTMENT/AKTIVASI_BPJS';
  static const String kodePerusahaan = 'REKRUTMENT/KODE_PERUSAHAAN';

  /// Get menu details (icon, route) based on menu ID
  static Map<String, dynamic> getMenuDetails(String id) {
    switch (id) {
      case verifikasiData:
        return {
          'icon': 'assets/images/icon/icon_verifikasi_data.svg',
          'route': RoutePaths.verificationData,
          'isAsset': true,
        };
      case perjanjianKerja:
        return {
          'icon': 'assets/images/icon/icon_verifikasi_data_hrManager.svg',
          'route': RoutePaths.employeeVerification,
          'isAsset': true,
        };
      case aktivasiBpjs:
        return {
          'icon': 'assets/images/icon/aktivasi_bpjs.svg',
          'route': null, // Will be implemented later
          'isAsset': true,
        };
      case kodePerusahaan:
        return {
          'icon': 'assets/images/icon/icon_verifikasi_data.svg',
          'route': RoutePaths.companyCode,
          'isAsset': true,
        };
      default:
        return {
          'icon': 'assets/images/icon/logo.png', // Default icon
          'route': null,
          'isAsset': true,
        };
    }
  }

  /// Get localized menu label
  static String getMenuLabel(BuildContext context, String id) {
    switch (id) {
      case verifikasiData:
        return 'Verifikasi Data';
      case perjanjianKerja:
        return 'Perjanjian Kerja';
      case aktivasiBpjs:
        return 'Aktivasi BPJS';
      case kodePerusahaan:
        return 'Kode Perusahaan';
      default:
        // Fallback to a readable name from ID
        return id
            .split('/')
            .last
            .replaceAll('_', ' ')
            .toLowerCase()
            .split(' ')
            .map((word) {
              return word[0].toUpperCase() + word.substring(1);
            })
            .join(' ');
    }
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
