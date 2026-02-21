// App constants
class AppConstants {
  const AppConstants._();

  // Storage keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyRememberMe = 'remember_me';
  static const String keyBranchCode = 'branch_code';
  static const String keyIsAdmin = 'is_admin';

  // Auth endpoints (V1 compatible)
  static const String endpointLogin = '/employee/login';
  static const String endpointLogout = '/auth/logout';
  static const String endpointRegister = '/employee/register';
  static const String endpointRefreshToken = '/employee/refresh-token';
  static const String endpointGetByToken = '/employee/get-by-token';

  // Home endpoints (V1 compatible)
  static const String endpointEmployeeProfile = '/employee/profile';
  static const String endpointEmployeeMenus =
      '/employee/employee-menu-application';
  static const String endpointNotificationCount = '/notification/count';

  // Profile endpoints (V1 compatible)
  static const String endpointUpdateProfile = '/employee/profile';
  static const String endpointUpdateProfilePicture =
      '/employee/employee-selfie';

  // Notification endpoints (V1 compatible)
  static const String endpointNotifications =
      '/employee/employee-notification/get-by-employee-id';
  static const String endpointMarkAsRead = '/employee-notification/read';
  static const String endpointMarkAllAsRead =
      '/employee/employee-notification/read-all-by-employee';
  static const String endpointDeleteAllRead =
      '/employee/employee-notification/delete-all-by-employee';

  // Absensi endpoints
  static const String endpointGetTodayEmployee =
      '/attendance/get-today-employee';
  static const String endpointGetTodayWorker =
      '/attendance/worker/get-today-worker';
  static const String endpointJobTitleMenu =
      '/employee/job-title-menu-application';
  static const String endpointSubmitAttendance = '/attendance/v2';
  static const String endpointSubmitAttendanceWorker = '/attendance/worker';

  // Error messages
  static const String errorNoInternet =
      'No internet connection. Please check your network.';
  static const String errorServerError =
      'Server error. Please try again later.';
  static const String errorUnknown = 'An unexpected error occurred.';
  static const String errorTimeout = 'Connection timeout. Please try again.';

  // Success messages
  static const String successLogin = 'Login successful';
  static const String successLogout = 'Logout successful';
  static const String successRegister = 'Registration successful';

  // Biodata
  static const biodata = _BiodataConstants();

  // Menu
  static const menu = _MenuConstraints._();
}

class _BiodataConstants {
  const _BiodataConstants();
  // Biodata
  final String name = "NAMA_LENGKAP";
  final String nickname = "NAMA_PANGGILAN";
  final String nik = "NIK";

  final String province = "PROVINSI";
  final String regency = "KABUPATEN";
  final String district = "KECAMATAN";
  final String village = "KELURAHAN";
  final String postalCode = "KODE_POS";
  final String address = "ALAMAT";

  final String currentProvince = "PROVINSI_DOMISILI";
  final String currentRegency = "KABUPATEN_DOMISILI";
  final String currentDistrict = "KECAMATAN_DOMISILI";
  final String currentVillage = "KELURAHAN_DOMISILI";
  final String currentPostalCode = "KODE_POS_DOMISILI";
  final String currentAddress = "ALAMAT_DOMISILI";

  final String sameCurrentAddress = "SESUAI_ALAMAT_KTP";

  final String residenceStatus = "STATUS_TEMPAT_TINGGAL";
  final String phone = "HP";
  final String emergencyPhone = "HP_DARURAT";
  final String gender = "JK";
  final String birthPlace = "TEMPAT_LAHIR";
  final String birthDate = "TGL_LAHIR";
  final String religion = "AGAMA";

  // Family
  final String fatherName = "NAMA_AYAH";
  final String fatherAge = "USIA_AYAH";
  final String fatherJob = "PEKERJAAN_AYAH";
  final String fatherCompany = "PERUSAHAAN_AYAH";
  final String motherName = "NAMA_IBU";
  final String motherAge = "USIA_IBU";
  final String motherJob = "PEKERJAAN_IBU";
  final String motherCompany = "PERUSAHAAN_IBU";
  final String spouseName = "NAMA_PASANGAN";
  final String spouseAge = "USIA_PASANGAN";
  final String spouseJob = "PEKERJAAN_PASANGAN";
  final String spouseCompany = "PERUSAHAAN_PASANGAN";

  // Education
  final String lastEducation = "LAST_EDUCATION";

  final String namePrimarySchool = "NAME_PRIMARY_SCHOOL";
  final String startYearPrimarySchool = "START_YEAR_PRIMARY_SCHOOL";
  final String endYearPrimarySchool = "END_YEAR_PRIMARY_SCHOOL";

  final String nameJuniorSchool = "NAME_JUNIOR_SCHOOL";
  final String startYearJuniorSchool = "START_YEAR_JUNIOR_SCHOOL";
  final String endYearJuniorSchool = "END_YEAR_JUNIOR_SCHOOL";

  final String nameSeniorSchool = "NAME_SENIOR_SCHOOL";
  final String startYearSeniorSchool = "START_YEAR_SENIOR_SCHOOL";
  final String endYearSeniorSchool = "END_YEAR_SENIOR_SCHOOL";

  final String nameBachelor = "NAME_BACHELOR";
  final String majorBachelor = "MAJOR_BACHELOR";
  final String startYearBachelor = "START_YEAR_BACHELOR";
  final String endYearBachelor = "END_YEAR_BACHELOR";
  final String ipkBachelor = "IPK_BACHELOR";
  final String titleBachelor = "TITLE_BACHELOR";

  final String nameMaster = "NAME_MASTER";
  final String majorMaster = "MAJOR_MASTER";
  final String startYearMaster = "START_YEAR_MASTER";
  final String endYearMaster = "END_YEAR_MASTER";
  final String ipkMaster = "IPK_MASTER";
  final String titleMaster = "TITLE_MASTER";

  final String nameDoctor = "NAME_DOCTOR";
  final String majorDoctor = "MAJOR_DOCTOR";
  final String startYearDoctor = "START_YEAR_DOCTOR";
  final String endYearDoctor = "END_YEAR_DOCTOR";
  final String ipkDoctor = "IPK_DOCTOR";
  final String titleDoctor = "TITLE_DOCTOR";
}

class _MenuConstraints {
  const _MenuConstraints._();
  final String absensi = "ABSENSI";
  final String mengamati = "MENGAMATI";
  final String persetujuan = "PERSETUJUAN";
  final String rencanaKerja = "RENCANA_KERJA";
  final String permintaan = "PERMINTAAN";
  final String tugas = "TUGAS";
  final String pengajuan = "PENGAJUAN";
  final String administrasi = "ADMINISTRASI";
  final String arsip = "ARSIP";
  final String dataAbsensi = "DATA_ABSENSI";
  final String dataKaryawan = "DATA_KARYAWAN";
  final String proyek = "PROYEK";
  final String kpi = "KPI";
  final String aduan = "ADUAN";
  final String dataPayroll = "DATA_PAYROLL";
  final String kasir = "KASIR";
  final String akuntansi = "AKUNTANSI";
  final String rekrutment = "REKRUTMENT";
  final String pengaturan = "PENGATURAN";
  final String updateKontrak = "UPDATE_KONTRAK";
  final String database = "DATABASE";

  final subPengaturan = const _PengaturanConstraints._();
  final subRekrutmen = const _RekrutmenConstraints._();
  final subArsip = const _ArsipConstraints._();
}

class _ArsipConstraints {
  const _ArsipConstraints._();
  final String strukturOrganisasi = "ARSIP/STRUKTUR_ORGANISASI";
  final String registrasi = "ARSIP/REGISTRASI";
  final String pernyataan = "ARSIP/PERNYATAAN";
  final String perjanjian = "ARSIP/PERJANJIAN";
  final String dataKaryawan = "ARSIP/DATA_KARYAWAN";
  final String kehadiran = "ARSIP/KEHADIRAN";
  final String lembur = "ARSIP/LEMBUR";
  final String izin = "ARSIP/IZIN";
  final String cuti = "ARSIP/CUTI";
  final String sakit = "ARSIP/SAKIT";
  final String absenDimanaSaja = "ARSIP/ABSEN_DIMANA_SAJA";
  final String serahTerima = "ARSIP/SERAH_TERIMA";
  final String pengunduranDiri = "ARSIP/PENGUNDURAN_DIRI";
  final String kpi = "ARSIP/KPI";
  final String permintaan = "ARSIP/PERMINTAAN";
  final String rencanaKerja = "ARSIP/RENCANA_KERJA";
  final String tugas = "ARSIP/TUGAS";
  final String potongan = "ARSIP/POTONGAN";
  final String pendapatan = "ARSIP/PENDAPATAN";
  final String pinjaman = "ARSIP/PINJAMAN";
  final String kenaikanGaji = "ARSIP/KENAIKAN_GAJI";
  final String penurunanGaji = "ARSIP/PENURUNAN_GAJI";
  final String promosiKaryawan = "ARSIP/PROMOSI_KARYAWAN";
  final String demoKaryawan = "ARSIP/DEMOSI_KARYAWAN";
  final String mutasiKaryawan = "ARSIP/MUTASI_KARYAWAN";
  final String gaji = "ARSIP/GAJI";
  final String anggaran = "ARSIP/ANGGARAN";

  final tipeDokumen = const _TipeDokumenConstants._();
}

class _TipeDokumenConstants {
  const _TipeDokumenConstants._();
  final String syaratDanKetentuan = "SYARAT DAN KETENTUAN PENGGUNAAN APLIKASI";
  final String privacyPolicy = "KEBIJAKAN PRIVASI PENGGUNAAN APLIKASI";
  final String peraturanPerusahaan = "PERATURAN PERUSAHAAN";
  final String rekeningBank = "SURAT PERNYATAAN REKENING BANK";
  final String tandaTangan = "SURAT PERNYATAAN TANDA TANGAN";
  final String pernyataan = "SURAT PERNYATAAN";
  final String perjanjianKerja = "SURAT PERJANJIAN KERJA";
  final String suratPernyataan1 = "SURAT PERNYATAAN 1";
  final String suratPernyataan2 = "SURAT PERNYATAAN 2";
}

class _RekrutmenConstraints {
  const _RekrutmenConstraints._();
  final String verifikasiData = 'REKRUTMENT/VERIFIKASI_DATA';
  final String perjanjianKerja = 'REKRUTMENT/PERJANJIAN_KERJA';
  final String aktivasiBpjs = 'REKRUTMENT/AKTIVASI_BPJS';
  final String kodePerusahaan = 'REKRUTMENT/KODE_PERUSAHAAN';
  final String eMatrai = 'REKRUTMENT/E_MATRAI';
}

class _PengaturanConstraints {
  const _PengaturanConstraints._();
  final String absensi = "PENGATURAN/ABSENSI";

  final subAbsensi = const _PengaturanAbsensiConstraints._();
}

class _PengaturanAbsensiConstraints {
  const _PengaturanAbsensiConstraints._();
  final String penempatanKerja = "PENGATURAN/ABSENSI/PENEMPATAN_KERJA";
  final String zonasi = "PENGATURAN/ABSENSI/ZONASI";
  final String jamKerja = "PENGATURAN/ABSENSI/JAM_KERJA";
  final String karyawan = "PENGATURAN/ABSENSI/KARYAWAN";
  final String pekerjaHarian = "PENGATURAN/ABSENSI/PEKERJA_HARIAN";
  final String hariLiburCutiBersama =
      "PENGATURAN/ABSENSI/HARI_LIBUR_CUTI_BERSAMA";
  final String lembur = "PENGATURAN/ABSENSI/LEMBUR";
  final String absenDimanaSaja = "PENGATURAN/ABSENSI/ABSEN_DIMANA_SAJA";
  final String perbaikkanKehadiran = "PENGATURAN/ABSENSI/PERBAIKKAN_KEHADIRAN";
}
