import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';

class MenuConfig {
  // ==================== MENU CODES ====================

  // ==================== ICON MAPPING ====================

  static final Map<String, String> _iconMap = {
    // Main Menus
    AppConstants.menu.absensi: 'assets/images/icon/absensi.png',
    AppConstants.menu.mengamati: 'assets/images/icon/monitoring_payroll.png',
    AppConstants.menu.persetujuan: 'assets/images/icon/approval.png',
    AppConstants.menu.rencanaKerja: 'assets/images/icon/rencanakerja.png',
    AppConstants.menu.permintaan: 'assets/images/icon/permintaan.png',
    AppConstants.menu.tugas: 'assets/images/icon/tugas.png',
    AppConstants.menu.pengajuan: 'assets/images/icon/pengajuan.png',
    AppConstants.menu.administrasi: 'assets/images/icon/administrasi.png',
    AppConstants.menu.arsip: 'assets/images/icon/arsip.png',
    AppConstants.menu.dataAbsensi: 'assets/images/icon/data_absensi.png',
    AppConstants.menu.dataKaryawan: 'assets/images/icon/data_karyawan.png',
    AppConstants.menu.proyek: 'assets/images/icon/proyek.png',
    AppConstants.menu.aduan: 'assets/images/icon/assistant.png',
    AppConstants.menu.dataPayroll: 'assets/images/icon/data_payroll.png',
    AppConstants.menu.kasir: 'assets/images/icon/cashier-png.png',
    AppConstants.menu.akuntansi: 'assets/images/icon/akuntansi-png.png',
    AppConstants.menu.rekrutment: 'assets/images/icon/rekrutmen.png',
    AppConstants.menu.kpi: 'assets/images/icon/KPI.png',
    AppConstants.menu.pengaturan: 'assets/images/icon/setting_icon.png',
    AppConstants.menu.updateKontrak: 'assets/images/icon/update_kontrak.png',
  };

  // ==================== ROUTE MAPPING ====================

  static final Map<String, String> _routeMap = {
    // Main Menus
    AppConstants.menu.absensi: AppRoutes.absensi.path,
    AppConstants.menu.mengamati: AppRoutes.monitoringList.path,
    AppConstants.menu.persetujuan: AppRoutes.approvalList.path,
    AppConstants.menu.rencanaKerja: AppRoutes.workerPlanManager.path,
    AppConstants.menu.permintaan: AppRoutes.permintaan.path,
    AppConstants.menu.tugas: AppRoutes.listFeature.path,
    AppConstants.menu.pengajuan: AppRoutes.requestHomeScreen.path,
    AppConstants.menu.administrasi: AppRoutes.administration.path,
    AppConstants.menu.arsip: AppRoutes.archiveMenu.path,
    AppConstants.menu.dataAbsensi: AppRoutes.dataAbsensi.path,
    AppConstants.menu.dataKaryawan: AppRoutes.dataKaryawanList.path,
    AppConstants.menu.proyek: AppRoutes.listProyek.path,
    AppConstants.menu.aduan: AppRoutes.reportList.path,
    AppConstants.menu.dataPayroll: AppRoutes.dataListPayroll.path,
    AppConstants.menu.kasir: AppRoutes.approvalNew.path,
    AppConstants.menu.akuntansi: AppRoutes.approvalNew.path,
    AppConstants.menu.rekrutment: AppRoutes.recruitment.path,
    AppConstants.menu.kpi: AppRoutes.kpi.path,
    AppConstants.menu.pengaturan: AppRoutes.settings.path,
    AppConstants.menu.updateKontrak: AppRoutes.contractUpdates.path,
  };

  // ==================== PUBLIC METHODS ====================

  static String getIconPath(String menuCode) {
    return _iconMap[menuCode] ?? 'assets/images/icon/logo.png';
  }

  static String? getRoute(String menuCode) {
    return _routeMap[menuCode];
  }

  static bool hasIcon(String menuCode) {
    return _iconMap.containsKey(menuCode);
  }

  static bool hasRoute(String menuCode) {
    return _routeMap.containsKey(menuCode);
  }

  static List<String> get mainMenuCodes => [
    AppConstants.menu.absensi,
    AppConstants.menu.mengamati,
    AppConstants.menu.persetujuan,
    AppConstants.menu.rencanaKerja,
    AppConstants.menu.permintaan,
    AppConstants.menu.tugas,
    AppConstants.menu.pengajuan,
    AppConstants.menu.administrasi,
    AppConstants.menu.arsip,
    AppConstants.menu.dataAbsensi,
    AppConstants.menu.dataKaryawan,
    AppConstants.menu.proyek,
    AppConstants.menu.aduan,
    AppConstants.menu.dataPayroll,
    AppConstants.menu.kasir,
    AppConstants.menu.akuntansi,
    AppConstants.menu.rekrutment,
    AppConstants.menu.kpi,
    AppConstants.menu.pengaturan,
  ];
}
