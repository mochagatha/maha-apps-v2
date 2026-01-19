import 'package:maha_apps_v2/core/router/route_paths.dart';

class MenuMapper {
  static const String absensi = 'ABSENSI_PEGAWAI';
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
  static const String rekrutment = 'REKRUTMEN';
  static const String pengaturan = 'PENGATURAN';
  static const String updateKontrak = 'UPDATE_KONTRAK';

  static Map<String, dynamic> getMenuDetails(String id) {
    switch (id) {
      case absensi:
        return {
          'icon': 'assets/images/icon/absensi.png',
          'route': RoutePaths.absensi, // Make sure this exists in RoutePaths
          'isAsset': true,
        };
      case mengamati:
        return {
          'icon': 'assets/images/icon/monitoring_payroll.png',
          'route': RoutePaths.monitoringList, // Make sure this exists
          'isAsset': true,
        };
      case persetujuan:
        return {
          'icon': 'assets/images/icon/approval.png',
          'route': RoutePaths.approvalList,
          'isAsset': true,
        };
      case rencanaKerja:
        return {
          'icon': 'assets/images/icon/rencanakerja.png',
          'route': RoutePaths.workerPlanManager,
          'isAsset': true,
        };
      case permintaan:
        return {
          'icon': 'assets/images/icon/permintaan.png',
          'route': RoutePaths.permintaan,
          'isAsset': true,
        };
      case tugas:
        return {
          'icon': 'assets/images/icon/tugas.png',
          'route': RoutePaths.listFeature,
          'isAsset': true,
        };
      case pengajuan:
        return {
          'icon': 'assets/images/icon/pengajuan.png',
          'route': RoutePaths.requestHomeScreen,
          'isAsset': true,
        };
      case administrasi:
        return {
          'icon': 'assets/images/icon/administrasi.png',
          'route': RoutePaths.administration,
          'isAsset': true,
        };
      case arsip:
        return {
          'icon': 'assets/images/icon/arsip.png',
          'route': RoutePaths.arsipMenu,
          'isAsset': true,
        };
      case dataAbsensi:
        return {
          'icon': 'assets/images/icon/data_absensi.png',
          'route': RoutePaths.dataAbsensi,
          'isAsset': true,
        };
      case dataKaryawan:
        return {
          'icon': 'assets/images/icon/data_karyawan.png',
          'route': RoutePaths.dataKaryawanList,
          'isAsset': true,
        };
      case proyek:
        return {
          'icon': 'assets/images/icon/proyek.png',
          'route': RoutePaths.listProyek,
          'isAsset': true,
        };
      case aduan:
        return {
          'icon': 'assets/images/icon/assistant.png',
          'route': RoutePaths.reportList,
          'isAsset': true,
        };
      case dataPayroll:
        return {
          'icon': 'assets/images/icon/data_payroll.png',
          'route': RoutePaths.dataListPayroll,
          'isAsset': true,
        };
      case kasir:
        return {
          'icon': 'assets/images/icon/cashier-png.png',
          'route': RoutePaths.approvalNew,
          'isAsset': true,
        };
      case akuntansi:
        return {
          'icon': 'assets/images/icon/akuntansi-png.png',
          'route': RoutePaths.approvalNew,
          'isAsset': true,
        };
      case rekrutment:
        return {
          'icon': 'assets/images/icon/rekrutmen.png',
          'route': RoutePaths.recruitment,
          'isAsset': true,
        };
      case pengaturan:
        return {
          'icon': 'assets/images/icon/setting_icon.png',
          'route': RoutePaths.setting,
          'isAsset': true,
        };
      case updateKontrak:
        return {
          'icon': 'assets/images/icon/update_kontrak.png',
          'route': RoutePaths.contractUpdates,
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
}
