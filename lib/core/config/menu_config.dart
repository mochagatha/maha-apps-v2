import 'package:maha_apps_v2/core/router/app_routes.dart';

class MenuConfig {
  // ==================== MENU CODES ====================

  // Main Menus
  static const String absensi = 'ABSENSI';
  static const String mengamati = 'MENGAMATI';
  static const String persetujuan = 'PERSETUJUAN';
  static const String rencanaKerja = 'RENCANA_KERJA';
  static const String permintaan = 'PERMINTAAN';
  static const String tugas = 'TUGAS';
  static const String pengajuan = 'PENGAJUAN';
  static const String administrasi = 'ADMINISTRASI';
  static const String arsip = 'ARSIP';
  static const String dataAbsensi = 'DATA_ABSENSI';
  static const String dataKaryawan = 'DATA_KARYAWAN';
  static const String proyek = 'PROYEK';
  static const String aduan = 'ADUAN';
  static const String dataPayroll = 'DATA_PAYROLL';
  static const String kasir = 'KASIR';
  static const String akuntansi = 'AKUNTANSI';
  static const String rekrutment = 'REKRUTMENT';
  static const String kpi = 'KPI';
  static const String pengaturan = 'PENGATURAN';
  static const String updateKontrak = 'UPDATE_KONTRAK';

  // ==================== ICON MAPPING ====================

  static const Map<String, String> _iconMap = {
    // Main Menus
    absensi: 'assets/images/icon/absensi.png',
    mengamati: 'assets/images/icon/monitoring_payroll.png',
    persetujuan: 'assets/images/icon/approval.png',
    rencanaKerja: 'assets/images/icon/rencanakerja.png',
    permintaan: 'assets/images/icon/permintaan.png',
    tugas: 'assets/images/icon/tugas.png',
    pengajuan: 'assets/images/icon/pengajuan.png',
    administrasi: 'assets/images/icon/administrasi.png',
    arsip: 'assets/images/icon/arsip.png',
    dataAbsensi: 'assets/images/icon/data_absensi.png',
    dataKaryawan: 'assets/images/icon/data_karyawan.png',
    proyek: 'assets/images/icon/proyek.png',
    aduan: 'assets/images/icon/assistant.png',
    dataPayroll: 'assets/images/icon/data_payroll.png',
    kasir: 'assets/images/icon/cashier-png.png',
    akuntansi: 'assets/images/icon/akuntansi-png.png',
    rekrutment: 'assets/images/icon/rekrutmen.png',
    kpi: 'assets/images/icon/KPI.png',
    pengaturan: 'assets/images/icon/setting_icon.png',
    updateKontrak: 'assets/images/icon/update_kontrak.png',
  };

  // ==================== ROUTE MAPPING ====================

  static final Map<String, String> _routeMap = {
    // Main Menus
    absensi: AppRoutes.absensi.path,
    mengamati: AppRoutes.monitoringList.path,
    persetujuan: AppRoutes.approvalList.path,
    rencanaKerja: AppRoutes.workerPlanManager.path,
    permintaan: AppRoutes.permintaan.path,
    tugas: AppRoutes.listFeature.path,
    pengajuan: AppRoutes.requestHomeScreen.path,
    administrasi: AppRoutes.administration.path,
    arsip: AppRoutes.arsipMenu.path,
    dataAbsensi: AppRoutes.dataAbsensi.path,
    dataKaryawan: AppRoutes.dataKaryawanList.path,
    proyek: AppRoutes.listProyek.path,
    aduan: AppRoutes.reportList.path,
    dataPayroll: AppRoutes.dataListPayroll.path,
    kasir: AppRoutes.approvalNew.path,
    akuntansi: AppRoutes.approvalNew.path,
    rekrutment: AppRoutes.recruitment.path,
    kpi: AppRoutes.kpi.path,
    pengaturan: AppRoutes.settings.path,
    updateKontrak: AppRoutes.contractUpdates.path,
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
    absensi,
    mengamati,
    persetujuan,
    rencanaKerja,
    permintaan,
    tugas,
    pengajuan,
    administrasi,
    arsip,
    dataAbsensi,
    dataKaryawan,
    proyek,
    aduan,
    dataPayroll,
    kasir,
    akuntansi,
    rekrutment,
    kpi,
    pengaturan,
  ];
}
