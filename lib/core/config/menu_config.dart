import 'package:maha_apps_v2/core/router/route_paths.dart';

/// Centralized Menu Configuration
/// Contains all menu codes, icons, and routes mapping
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

  // Absensi Submenus
  static const String absensiHadir = 'ABSENSI/HADIR';
  static const String absensiLembur = 'ABSENSI/LEMBUR';
  static const String absensiIzin = 'ABSENSI/IZIN';
  static const String absensiSakit = 'ABSENSI/SAKIT';
  static const String absensiCuti = 'ABSENSI/CUTI';
  static const String absensiPengawasan = 'ABSENSI/PENGAWASAN_1';
  static const String absensiPengawasan2 = 'PENGAWASAN_2';
  static const String absenDimanaSaja = 'ABSEN_DIMANA_SAJA';

  // Persetujuan Submenus
  static const String persetujuanPengawasan = 'PERSETUJUAN/PENGAWASAN';
  static const String persetujuanRencanaKerja = 'PERSETUJUAN/RENCANA_KERJA';
  static const String persetujuanSuratTugas = 'PERSETUJUAN/SURAT_TUGAS';
  static const String persetujuanTeguranPeringatan = 'PERSETUJUAN/TEGURAN_PERINGATAN';
  static const String persetujuanSerahTerima = 'PERSETUJUAN/SERAH_TERIMA';
  static const String persetujuanPotongan = 'PERSETUJUAN/POTONGAN';
  static const String persetujuanPendapatan = 'PERSETUJUAN/PENDAPATAN';
  static const String persetujuanCostControl = 'PERSETUJUAN/COST_CONTROL';
  static const String persetujuanVerifikasiData = 'PERSETUJUAN/VERIFIKASI_DATA';
  static const String persetujuanUbahKontrak = 'PERSETUJUAN/UBAH_KONTRAK';
  static const String persetujuanPromosiKaryawan = 'PERSETUJUAN/PROMOSI_KARYAWAN';
  static const String persetujuanDemosiKaryawan = 'PERSETUJUAN/DEMOSI_KARYAWAN';
  static const String persetujuanMutasiKaryawan = 'PERSETUJUAN/MUTASI_KARYAWAN';
  static const String persetujuanAbsenDimanaSaja = 'PERSETUJUAN/ABSEN_DIMANA_SAJA';
  static const String persetujuanKenaikanGaji = 'PERSETUJUAN/KENAIKAN_GAJI';
  static const String persetujuanPenurunanGaji = 'PERSETUJUAN/PENURUNAN_GAJI';
  static const String persetujuanLemburDirektur = 'PERSETUJUAN/LEMBUR/DIREKTUR';
  static const String persetujuanIzinDirektur = 'PERSETUJUAN/IZIN/DIREKTUR';
  static const String persetujuanSakitDirektur = 'PERSETUJUAN/SAKIT/DIREKTUR';
  static const String persetujuanCutiDirektur = 'PERSETUJUAN/CUTI/DIREKTUR';
  static const String persetujuanPerjanjianKerjaDirektur = 'PERSETUJUAN/PERJANJIAN_KERJA/DIREKTUR';
  static const String persetujuanGajiDirektur = 'PERSETUJUAN/GAJI/DIREKTUR';
  static const String persetujuanPinjamanDirektur = 'PERSETUJUAN/PINJAMAN/DIREKTUR';

  // Mengamati Submenus
  static const String mengamatiLogAktifitas = 'MENGAMATI/LOG_AKTIFITAS';
  static const String mengamatiMonitoringKpi = 'MENGAMATI/MONITORING_KPI';
  static const String mengamatiGaji = 'MENGAMATI/GAJI';
  static const String mengamatiAbsen = 'MENGAMATI/ABSEN';
  static const String mengamatiRencanaKerja = 'MENGAMATI/RENCANA_KERJA';
  static const String mengamatiTugas = 'MENGAMATI/TUGAS';

  // Rencana Kerja Submenus
  static const String rencanaKerjaRencanaKerja = 'RENCANA_KERJA/RENCANA_KERJA';
  static const String rencanaKerjaMonitoring = 'RENCANA_KERJA/MONITORING';

  // Permintaan Submenus
  static const String permintaanDaftarPermintaan = 'PERMINTAAN/DAFTAR_PERMINTAAN';
  static const String permintaanPemberianPermintaan = 'PERMINTAAN/PEMBERIAN_PERMINTAAN';

  // Tugas Submenus
  static const String tugasDaftarTugas = 'TUGAS/DAFTAR_TUGAS';
  static const String tugasPemberianTugas = 'TUGAS/PEMBERIAN_TUGAS';

  // Pengajuan Submenus
  static const String pengajuanPinjaman = 'PENGAJUAN/PINJAMAN';
  static const String pengajuanPotongan = 'PENGAJUAN/POTONGAN';
  static const String pengajuanPendapatan = 'PENGAJUAN/PENDAPATAN';
  static const String pengajuanKenaikanGaji = 'PENGAJUAN/KENAIKAN_GAJI';
  static const String pengajuanPenurunanGaji = 'PENGAJUAN/PENURUNAN_GAJI';

  // Administrasi Submenus
  static const String administrasiMenuSuratTugas = 'ADMINISTRASI/MENU_SURAT_TUGAS';
  static const String administrasiSuratTeguranPeringatan = 'ADMINISTRASI/SURAT_TEGURAN_PERINGATAN';
  static const String administrasiSuratSerahTerima = 'ADMINISTRASI/SURAT_SERAH_TERIMA';
  static const String administrasiUbahStatusKontrak = 'ADMINISTRASI/UBAH_STATUS_KONTRAK';
  static const String administrasiPromosiKaryawan = 'ADMINISTRASI/PROMOSI_KARYAWAN';
  static const String administrasiDemosiKaryawan = 'ADMINISTRASI/DEMOSI_KARYAWAN';
  static const String administrasiMutasiKaryawan = 'ADMINISTRASI/MUTASI_KARYAWAN';
  static const String administrasiAbsenDimanaSaja = 'ADMINISTRASI/ABSEN_DIMANA_SAJA';

  // Rekrutment Submenus
  static const String rekrutmentVerifikasiData = 'REKRUTMENT/VERIFIKASI_DATA';
  static const String rekrutmentPerjanjianKerja = 'REKRUTMENT/PERJANJIAN_KERJA';
  static const String rekrutmentAktivasiBpjs = 'REKRUTMENT/AKTIVASI_BPJS';

  // Data Payroll Submenus
  static const String dataPayrollPengajuanGaji = 'DATA_PAYROLL/PENGAJUAN_GAJI';
  static const String dataPayrollLaporanGaji = 'DATA_PAYROLL/LAPORAN_GAJI';
  static const String dataPayrollGajiPekerjaHarian = 'DATA_PAYROLL/PENGAJUAN_GAJI/GAJI_PEKERJA_HARIAN';
  static const String dataPayrollGajiKaryawan = 'DATA_PAYROLL/PENGAJUAN_GAJI/GAJI_KARYAWAN';

  // Kasir Submenus
  static const String kasirPengajuanGaji = 'KASIR/PENGAJUAN_GAJI';
  static const String kasirPinjaman = 'KASIR/PINJAMAN';
  static const String kasirGajiKaryawan = 'KASIR/PENGAJUAN_GAJI/GAJI_KARYAWAN';
  static const String kasirGajiPekerjaHarian = 'KASIR/PENGAJUAN_GAJI/GAJI_PEKERJA_HARIAN';

  // Akuntansi Submenus
  static const String akuntansiLaporanGaji = 'AKUNTANSI/LAPORAN_GAJI';

  // Data Absensi Submenus
  static const String dataAbsensiHariLibur = 'DATA_ABSENSI/HARI_LIBUR';
  static const String dataAbsensiDataIzinCutiSakit = 'DATA_ABSENSI/DATA_IZIN_CUTI_SAKIT';
  static const String dataAbsensiMonitoringAbsensi = 'DATA_ABSENSI/MONITORING_ABSENSI';
  static const String dataAbsensiRekapAbsensi = 'DATA_ABSENSI/REKAP_ABSENSI';

  // Data Karyawan Submenus
  static const String dataKaryawanKaryawan = 'DATA_KARYAWAN/KARYAWAN';
  static const String dataKaryawanAgenda = 'DATA_KARYAWAN/AGENDA';
  static const String dataKaryawanPenilaian = 'DATA_KARYAWAN/PENILAIAN';
  static const String dataKaryawanDaftarKaryawan = 'DATA_KARYAWAN/DAFTAR_KARYAWAN';
  static const String dataKaryawanPekerjaHarian = 'DATA_KARYAWAN/PEKERJA_HARIAN';

  // Aduan Submenus
  static const String aduanFakeGps = 'ADUAN/FAKE_GPS';
  static const String aduanTrackingJamKerja = 'ADUAN/TRACKING_JAM_KERJA';

  // Pengaturan Submenus
  static const String pengaturanPenempatanKerja = 'PENGATURAN/PENEMPATAN_KERJA';
  static const String pengaturanHirarkiOffice = 'PENGATURAN/HIRARKI_OFFICE';
  static const String pengaturanPengaturanLembur = 'PENGATURAN/PENGATURAN_LEMBUR';
  static const String pengaturanBpjs = 'PENGATURAN/BPJS';
  static const String pengaturanPph21 = 'PENGATURAN/PPH_21';
  static const String pengaturanJamKerja = 'PENGATURAN/JAM_KERJA';
  static const String pengaturanAksesLayar = 'PENGATURAN/AKSES_LAYAR';
  static const String pengaturanStrukturOrganisasi = 'PENGATURAN/STRUKTUR_ORGANISASI';
  static const String pengaturanLibur = 'PENGATURAN/LIBUR';
  static const String pengaturanTindakanKaryawan = 'PENGATURAN/TINDAKAN_KARYAWAN';
  static const String pengaturanFormatDanDraf = 'PENGATURAN/FORMAT_DAN_DRAF';
  static const String pengaturanPelcakanJamKerja = 'PENGATURAN/PELCAKAN_JAM_KERJA';
  static const String pengaturanKpi = 'PENGATURAN/KPI';
  static const String pengaturanBahasa = 'PENGATURAN/BAHASA';
  static const String pengaturanHakAksesMenu = 'PENGATURAN/HAK_AKSES_MENU';
  
  // Arsip Submenus
  static const String arsipStrukturOrganisasi = 'ARSIP/STRUKTUR_ORGANISASI';
  
  // Organizational Structure Submenus
  static const String strukturOrganisasiUtama = 'STRUKTUR_ORGANISASI/UTAMA';
  static const String strukturOrganisasiTingkatanPekerjaan = 'STRUKTUR_ORGANISASI/TINGKATAN_PEKERJAAN';
  static const String strukturOrganisasiDepartemen = 'STRUKTUR_ORGANISASI/DEPARTEMEN';
  static const String strukturOrganisasiJabatan = 'STRUKTUR_ORGANISASI/JABATAN';

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
  
  static const Map<String, String> _routeMap = {
    // Main Menus
    absensi: RoutePaths.absensi,
    mengamati: RoutePaths.monitoringList,
    persetujuan: RoutePaths.approvalList,
    rencanaKerja: RoutePaths.workerPlanManager,
    permintaan: RoutePaths.permintaan,
    tugas: RoutePaths.listFeature,
    pengajuan: RoutePaths.requestHomeScreen,
    administrasi: RoutePaths.administration,
    arsip: RoutePaths.arsipMenu,
    dataAbsensi: RoutePaths.dataAbsensi,
    dataKaryawan: RoutePaths.dataKaryawanList,
    proyek: RoutePaths.listProyek,
    aduan: RoutePaths.reportList,
    dataPayroll: RoutePaths.dataListPayroll,
    kasir: RoutePaths.approvalNew,
    akuntansi: RoutePaths.approvalNew,
    rekrutment: RoutePaths.recruitment,
    kpi: RoutePaths.kpi,
    pengaturan: RoutePaths.setting,
    updateKontrak: RoutePaths.contractUpdates,
    
    // Absensi Submenus
    absensiHadir: RoutePaths.attendancePresent,
    absensiLembur: RoutePaths.attendanceOvertime,
    absensiIzin: RoutePaths.attendancePermit,
    absensiSakit: RoutePaths.attendanceSick,
    absensiCuti: RoutePaths.attendanceLeave,
    absensiPengawasan: RoutePaths.attendanceSupervision,
    absensiPengawasan2: RoutePaths.attendanceSupervision2,
    absenDimanaSaja: RoutePaths.attendanceAnywhere,
    
    // Persetujuan Submenus
    persetujuanPengawasan: RoutePaths.approvalSupervision,
    persetujuanRencanaKerja: RoutePaths.approvalWorkPlan,
    persetujuanSuratTugas: RoutePaths.approvalAssignmentLetter,
    persetujuanTeguranPeringatan: RoutePaths.approvalWarning,
    persetujuanSerahTerima: RoutePaths.approvalHandover,
    persetujuanPotongan: RoutePaths.approvalDeduction,
    persetujuanPendapatan: RoutePaths.approvalIncome,
    persetujuanCostControl: RoutePaths.approvalCostControl,
    persetujuanVerifikasiData: RoutePaths.approvalDataVerification,
    persetujuanUbahKontrak: RoutePaths.approvalContractChange,
    persetujuanPromosiKaryawan: RoutePaths.approvalPromotion,
    persetujuanDemosiKaryawan: RoutePaths.approvalDemotion,
    persetujuanMutasiKaryawan: RoutePaths.approvalTransfer,
    persetujuanAbsenDimanaSaja: RoutePaths.approvalAttendanceAnywhere,
    persetujuanKenaikanGaji: RoutePaths.approvalSalaryIncrease,
    persetujuanPenurunanGaji: RoutePaths.approvalSalaryDecrease,
    persetujuanLemburDirektur: RoutePaths.approvalOvertimeDirector,
    persetujuanIzinDirektur: RoutePaths.approvalPermitDirector,
    persetujuanSakitDirektur: RoutePaths.approvalSickDirector,
    persetujuanCutiDirektur: RoutePaths.approvalLeaveDirector,
    persetujuanPerjanjianKerjaDirektur: RoutePaths.approvalAgreementDirector,
    persetujuanGajiDirektur: RoutePaths.approvalSalaryDirector,
    persetujuanPinjamanDirektur: RoutePaths.approvalLoanDirector,
    
    // Mengamati Submenus
    mengamatiLogAktifitas: RoutePaths.monitoringActivityLog,
    mengamatiMonitoringKpi: RoutePaths.monitoringKpi,
    mengamatiGaji: RoutePaths.monitoringSalary,
    mengamatiAbsen: RoutePaths.monitoringAttendance,
    mengamatiRencanaKerja: RoutePaths.monitoringWorkPlan,
    mengamatiTugas: RoutePaths.monitoringTask,
    
    // Rekrutment Submenus
    rekrutmentVerifikasiData: RoutePaths.verificationData,
    rekrutmentPerjanjianKerja: RoutePaths.recruitmentAgreement,
    rekrutmentAktivasiBpjs: RoutePaths.recruitmentBpjsActivation,
    
    // Organizational Structure
    arsipStrukturOrganisasi: RoutePaths.organizationalStructure,
    pengaturanStrukturOrganisasi: RoutePaths.organizationalStructure,
    strukturOrganisasiUtama: RoutePaths.structureMain,
    strukturOrganisasiTingkatanPekerjaan: RoutePaths.employmentLevel,
    strukturOrganisasiDepartemen: RoutePaths.departmentList,
    strukturOrganisasiJabatan: RoutePaths.jobTitleList,
  };


  // ==================== PUBLIC METHODS ====================

  /// Get icon path for menu code
  static String getIconPath(String menuCode) {
    return _iconMap[menuCode] ?? 'assets/images/icon/logo.png';
  }

  /// Get route for menu code
  static String? getRoute(String menuCode) {
    return _routeMap[menuCode];
  }

  /// Check if menu has icon
  static bool hasIcon(String menuCode) {
    return _iconMap.containsKey(menuCode);
  }

  /// Check if menu has route
  static bool hasRoute(String menuCode) {
    return _routeMap.containsKey(menuCode);
  }

  /// Get all main menu codes
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
