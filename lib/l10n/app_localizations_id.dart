// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'MAHA Apps';

  @override
  String get login => 'Masuk';

  @override
  String get register => 'Daftar disini';

  @override
  String get confirm => 'Konfirmasi';

  @override
  String get fieldRequired => 'Semua kolom wajib diisi';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata Sandi';

  @override
  String get confirmPassword => 'Konfirmasi Kata Sandi';

  @override
  String get fullname => 'Nama Lengkap';

  @override
  String get forgotPassword => 'Lupa kata sandi?';

  @override
  String get rememberMe => 'Tetap masuk';

  @override
  String get dontHaveAccount => 'Belum punya akun?';

  @override
  String get alreadyHaveAccount => 'Sudah punya akun?';

  @override
  String get enterEmail => 'Masukkan email anda...';

  @override
  String get enterPassword => 'Masukkan kata sandi anda...';

  @override
  String get enterFullname => 'Masukkan nama lengkap anda...';

  @override
  String get emailRequired => 'Email tidak boleh kosong';

  @override
  String get emailInvalid => 'Format email tidak valid';

  @override
  String get passwordRequired => 'Password tidak boleh kosong';

  @override
  String get passwordMinLength => 'Password minimal 6 karakter';

  @override
  String get passwordNotMatch => 'Password tidak sama';

  @override
  String get fullnameRequired => 'Nama lengkap tidak boleh kosong';

  @override
  String get createAccount => 'Buat Akun';

  @override
  String get createAccountTitle => 'Buat Akun Baru';

  @override
  String get accountType => 'Jenis Akun';

  @override
  String get employee => 'Karyawan';

  @override
  String get worker => 'Pekerja';

  @override
  String get registrationSuccess => 'Pendaftaran Berhasil!';

  @override
  String get registrationSuccessMessage =>
      'Silahkan login dengan akun yang telah didaftarkan';

  @override
  String get pinVerificationTitle => 'Masukkan Kode Verifikasi Perusahaan';

  @override
  String get pinVerificationMessage =>
      'Masukkan kode verifikasi perusahaan yang telah diberikan HRD';

  @override
  String get pinInvalid => 'Kode verifikasi tidak valid';

  @override
  String get termsAndConditionsTitle =>
      'Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi MAHA Apps Mobile';

  @override
  String get termsAndConditionsMessage =>
      'Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi merupakan ketentuan yang harus dibaca, dipahami, dan disetujui oleh pengguna sebelum mengakses atau menggunakan aplikasi MAHA Apps Mobile. Lihat selengkapnya di sini:';

  @override
  String get termsOfUse => 'Syarat & Ketentuan Penggunaan';

  @override
  String get privacyNotice => 'Pemberitahuan Privasi';

  @override
  String get agreeTerms =>
      'Dengan ini menyatakan Setuju, anda menerima segala isi Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi';

  @override
  String get iAgree => 'Saya Setuju';

  @override
  String copyright(String year) {
    return '© Copyright IT Maha $year';
  }

  @override
  String get selectRole => 'Pilih Role (Quick Fill)';

  @override
  String get loading => 'Sedang memuat...';

  @override
  String get retry => 'Coba Lagi';

  @override
  String get close => 'Tutup';

  @override
  String get profile => 'Profil';

  @override
  String get profilePicture => 'Foto Profil';

  @override
  String get profilePoints => 'Poin saat ini';

  @override
  String get profileFeatures => 'FITUR';

  @override
  String get profilePreferences => 'PREFERENSI';

  @override
  String get dataDiri => 'Data Diri';

  @override
  String get education => 'Pendidikan';

  @override
  String get skill => 'Skill';

  @override
  String get family => 'Keluarga';

  @override
  String get changePassword => 'Ubah Password';

  @override
  String get secureAccount => 'Keamanan Akun';

  @override
  String get logoutConfirmTitle =>
      'Apakah Anda yakin ingin keluar dari aplikasi?';

  @override
  String get logoutConfirmMessage => 'Keluar dari aplikasi';

  @override
  String get logout => 'Keluar';

  @override
  String get logoutConfirmation1 => 'Apakah Anda yakin ingin ';

  @override
  String get logoutConfirmation2 => 'keluar ';

  @override
  String get logoutConfirmation3 => 'dari aplikasi?';

  @override
  String get yes => 'Ya';

  @override
  String get no => 'Tidak';

  @override
  String get cancel => 'Batal';

  @override
  String get points => 'Poin';

  @override
  String get targetReached => 'Target tercapai 🎉';

  @override
  String appVersion(String version) {
    return 'Versi Aplikasi: $version';
  }

  @override
  String get statusRejectedTitle =>
      'Data diri anda ditolak, Segera cek pemberitahuannya !';

  @override
  String get checkDetails => 'Lihat Keterangan';

  @override
  String get statusInactive =>
      'Akun Anda Nonaktif. Silahkan hubungi HRD Maha segera !';

  @override
  String get statusBlacklisted =>
      'Akun masuk daftar hitam. Silahkan hubungi HRD Maha segera !';

  @override
  String get statusContractUnverified =>
      'Data Kontrak Anda Belum Diverifikasi. Silahkan hubungi HRD Maha segera !';

  @override
  String get statusInaccessible =>
      'Akun anda tidak dapat diakses. Silahkan hubungi HRD Maha segera !';

  @override
  String get contactAdmin => 'Hubungi Admin';

  @override
  String get contactAdminMessageInactive =>
      'Halo admin, Kenapa akun saya nonaktif, Terima Kasih';

  @override
  String get contactAdminMessageBlacklisted =>
      'Halo admin, Kenapa akun saya masuk daftar hitam, Terima Kasih';

  @override
  String get contactAdminMessageContract =>
      'Halo admin, Kenapa data kontrak saya belum diverifikasi, Terima Kasih';

  @override
  String get contactAdminMessageInaccessible =>
      'Halo admin, Kenapa akun saya tidak dapat diakses mohon dibantu, Terima Kasih';

  @override
  String get rejectStatusDetailsComingSoon =>
      'Detail Status Penolakan Segera Hadir';

  @override
  String get menuAbsensi => 'Absensi';

  @override
  String get menuMengamati => 'Mengamati';

  @override
  String get menuPersetujuan => 'Persetujuan';

  @override
  String get menuRencanaKerja => 'Rencana Kerja';

  @override
  String get menuPermintaan => 'Permintaan';

  @override
  String get menuTugas => 'Tugas';

  @override
  String get menuPengajuan => 'Pengajuan';

  @override
  String get menuAdministrasi => 'Administrasi';

  @override
  String get menuArsip => 'Arsip';

  @override
  String get menuDataAbsensi => 'Data Absensi';

  @override
  String get menuDataKaryawan => 'Data Karyawan';

  @override
  String get menuProyek => 'Proyek';

  @override
  String get menuAduan => 'Aduan';

  @override
  String get menuDataPayroll => 'Data Payroll';

  @override
  String get menuKasir => 'Kasir';

  @override
  String get menuAkuntansi => 'Akuntansi';

  @override
  String get menuRekrutmen => 'Rekrutmen';

  @override
  String get menuPengaturan => 'Pengaturan';

  @override
  String get menuUpdateKontrak => 'Update Kontrak';

  @override
  String get menuKpi => 'Monitoring KPI';

  @override
  String get verificationErrorTitle => 'Maaf Sebelumnya!';

  @override
  String get verificationErrorPart1 => 'Akun Anda belum ';

  @override
  String get verificationErrorPart2 => 'terverifikasi';

  @override
  String get verificationErrorPart3 => '. Silahkan\nhubungi ';

  @override
  String get verificationErrorPart4 => 'HRD';

  @override
  String get verificationErrorPart5 => ' Maha segera !';

  @override
  String get targetReachedSimplified => 'Target tercapai!';

  @override
  String pointsNotReached(int remaining) {
    return '$remaining Poin belum tercapai';
  }

  @override
  String get ePresensi => 'E-Presensi';

  @override
  String get pageNotFoundTitle => 'Halaman Tidak Ditemukan';

  @override
  String get pageNotFoundMessage =>
      'Halaman yang Anda cari tidak ditemukan atau fitur ini belum diimplementasikan.';

  @override
  String get back => 'Kembali';

  @override
  String get changeLanguage => 'Ubah Bahasa';

  @override
  String get selectLanguage => 'Pilih Bahasa';
}
