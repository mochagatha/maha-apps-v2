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
  String get menuKpi => 'Indikator Kinerja Utama (KPI)';

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

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageEnglish => 'Inggris';

  @override
  String get featureComingSoon => 'Fitur segera hadir!';

  @override
  String get menuPenempatanKerja => 'Penempatan dan Jam kerja';

  @override
  String get menuHariLibur => 'Hari Libur & Cuti Bersama';

  @override
  String get menuHirarkiOffice => 'Hirarki Office';

  @override
  String get menuLembur => 'Lembur';

  @override
  String get menuTindakanKaryawan => 'Tindakan Karyawan';

  @override
  String get menuBpjs => 'BPJS';

  @override
  String get menuPph21 => 'PPH 21';

  @override
  String get menuJamKerja => 'Jam Kerja';

  @override
  String get menuFormatDanDraf => 'Format dan Draf';

  @override
  String get menuAksesLayar => 'Akses Layar';

  @override
  String get menuHakAksesMenu => 'Hak Akses Menu';

  @override
  String get menuPelacakanJamKerja => 'Pelacakan Jam Kerja';

  @override
  String get menuStrukturOrganisasi => 'Struktur Organisasi';

  @override
  String get redeemPoints => 'Tukar Poin';

  @override
  String get performance => 'Performa';

  @override
  String get salarySlip => 'Slip Gaji';

  @override
  String get debtSlip => 'Slip Hutang';

  @override
  String get resignation => 'Pengunduran Diri';

  @override
  String get ok => 'Oke';

  @override
  String get verificationJobLevelTitle => 'Data Tingkatan Pekerjaan';

  @override
  String get dailyWorker => 'Pekerja Harian';

  @override
  String get dailyWorkerVerificationComingSoon =>
      'Fitur Verifikasi Data Pekerja Harian akan segera hadir!';

  @override
  String get companyCodeTitle => 'Kode Perusahaan';

  @override
  String get failedToLoadCompanyCode => 'Gagal Memuat Kode Perusahaan';

  @override
  String get companyCodeInstruction =>
      'Gunakan Kode Perusahaan yang dikelola oleh sistem dan akan berganti secara otomatis';

  @override
  String get refreshCodeTooltip => 'Refresh Kode';

  @override
  String get employeeVerificationTitle => 'Verifikasi Data Karyawan';

  @override
  String get featureUnderDevelopment => 'Fitur Dalam Pengembangan';

  @override
  String get employeeVerificationDevMessage =>
      'Halaman Verifikasi Data Karyawan sedang dalam tahap pengembangan. Fitur ini akan menampilkan daftar karyawan yang perlu diverifikasi dengan tab filter status.';

  @override
  String get menuVerifikasiData => 'Verifikasi Data';

  @override
  String get menuPerjanjianKerja => 'Perjanjian Kerja';

  @override
  String get menuAktivasiBpjs => 'Aktivasi BPJS';

  @override
  String get menuKodePerusahaan => 'Kode Perusahaan';

  @override
  String get recruitmentTitle => 'Rekrutmen';

  @override
  String get recruitmentEmpty => 'Tidak ada menu rekrutmen tersedia';

  @override
  String get errorOccurred => 'Terjadi kesalahan';

  @override
  String featureComingSoonDynamic(String label) {
    return 'Fitur $label akan segera hadir!';
  }

  @override
  String get underMonitoring => 'Kamu sedang dalam\npemantauan nih!';

  @override
  String get showChart => 'Tampilkan Bagan';

  @override
  String get archive => 'Arsip';

  @override
  String get deleteRole => 'Hapus Role';

  @override
  String get deleteStructureRoleTitle => 'Hapus Role Struktur';

  @override
  String get deleteStructureRoleMessage =>
      'Apakah Anda yakin ingin menghapus role ini?';

  @override
  String get jobLevelList => 'Daftar Tingkatan Pekerjaan';

  @override
  String get select => 'Pilih';

  @override
  String get sorryBeforehand => 'Maaf, Sebelumnya...';

  @override
  String get confirmAddJobLevelStructure =>
      'Apakah anda yakin ingin menambahkan Daftar Tingkatan Pekerjaan ke struktur utama ?';

  @override
  String get successExclamation => 'Berhasil!!';

  @override
  String get jobLevelAddedSuccess =>
      'Daftar tingkatan pekerjaan berhasil di Tambahkan';

  @override
  String get structureNotFound => 'Struktur tidak ditemukan';

  @override
  String get failedToAddRole => 'Gagal menambahkan role';

  @override
  String get roleDeletedSuccess => 'Role berhasil dihapus';

  @override
  String get noRolesAvailable => 'Tidak ada role yang tersedia';

  @override
  String get allRolesAdded => 'Semua role sudah ditambahkan';

  @override
  String get addMainStructureLevel => '+ Tingkatan Struktur Utama';

  @override
  String get mainStructure => 'Struktur Utama';

  @override
  String get emptyStructureTitle => 'Anda belum memiliki Struktur Utama';

  @override
  String get emptyStructureMessage =>
      'Anda harus menambahkan struktur anda terlebih\ndahulu.';

  @override
  String get welcomeGreetingTitle => 'Selamat Bergabung !';

  @override
  String get welcomeGreetingMessage =>
      'Semoga Anda dapat memberikan kontribusi terbaik bagi perusahaan PT. Maha Akbar Sejahtera.';

  @override
  String get director => 'Direktur';

  @override
  String get next => 'Selanjutnya';

  @override
  String get companyRegulationsTitle => 'Peraturan Perusahaan !';

  @override
  String get regulationPromptMessage =>
      'Sebelum Anda melanjutkan ke tahap pengisian data. Harap baca terlebih dahulu peraturan PT. Maha Akbar Sejahtera...!';

  @override
  String get agreeToRegulations =>
      'Dengan ini saya menyatakan bahwa saya menyetujui seluruh peraturan perusahaan';

  @override
  String get download => 'Unduh';

  @override
  String get continueAction => 'Lanjutkan';

  @override
  String get completePersonalDataTitle => 'Lengkapi Data diri Anda !';

  @override
  String get dataCompletionTimeMessage =>
      'Dalam pengisian formulir ini, Anda membutuhkan waktu 10 Menit. Harap diisi dengan sejujurnya yah !';

  @override
  String get spirit => 'Semangat';

  @override
  String get companySlogan => 'Be Great, Be Integrated';

  @override
  String get verificationFailed => 'Verifikasi Gagal';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get adminDataNotFound => 'Data admin tidak ditemukan.';

  @override
  String get faceVerification => 'Verifikasi Wajah';

  @override
  String get blinkInstruction => 'Kedipkan mata untuk menangkap gambar wajah';

  @override
  String get sendingData => 'Mengirim data...';

  @override
  String get resetYourPassword => 'Reset Kata Sandi Anda';

  @override
  String get enterEmailToResetPassword =>
      'Masukkan E-mail yang pernah terdaftar untuk melanjutkan reset password';

  @override
  String get emailHintExample => 'contoh : user@mahasejahtera.com';

  @override
  String get enterValidVerificationCode =>
      'Mohon masukkan kode verifikasi yang valid';

  @override
  String get verifyingOtp => 'Memverifikasi kode OTP...';

  @override
  String get otpIncorrect => 'Kode OTP Salah';

  @override
  String get otpIncorrectMessage =>
      'Kode OTP yang Anda masukkan tidak sesuai. Silakan coba lagi.';

  @override
  String get unexpectedErrorRetry =>
      'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.';

  @override
  String get enterVerificationCode => 'Masukkan Kode Verifikasi';

  @override
  String get verificationCodeSentToEmail =>
      'Kode verifikasi telah dikirim melalui e-mail ke ';

  @override
  String get verify => 'Verifikasi';

  @override
  String get didNotReceiveCode => 'Tidak menerima kode verifikasi? ';

  @override
  String get resend => 'Kirim Ulang';

  @override
  String resendIn(Object time) {
    return 'Kirim Ulang dalam $time';
  }

  @override
  String get resendingOtp => 'Mengirim ulang OTP...';

  @override
  String get otpResentSuccess => 'Kode OTP berhasil dikirim ulang!';

  @override
  String get otpResendFailed => 'Gagal Mengirim OTP';

  @override
  String get otpResendFailedMessage =>
      'Gagal mengirim ulang kode OTP. Silakan coba lagi.';

  @override
  String get verificationDataNotFound => 'Data Verifikasi Tidak Ditemukan';

  @override
  String get pleaseVerifyOtpFirst =>
      'Silakan lakukan verifikasi OTP terlebih dahulu.';

  @override
  String get changeYourPassword => 'Ubah Kata Sandi Anda';

  @override
  String get changePasswordInstruction =>
      'Silahkan ubah kata sandi lama Anda untuk keamanan Akun';

  @override
  String get enterNewPassword => 'Masukkan Kata Sandi Baru';

  @override
  String get confirmNewPassword => 'Konfirmasi Kata Sandi Baru';

  @override
  String get changingPassword => 'Mengubah kata sandi...';

  @override
  String get success => 'Berhasil';

  @override
  String get passwordChangedSuccess => 'Kata sandi Anda telah berhasil diubah!';

  @override
  String get passwordChangeFailed => 'Gagal Mengubah Kata Sandi';

  @override
  String get passwordChangeFailedMessage =>
      'Gagal mengubah kata sandi. Silakan coba lagi.';

  @override
  String get save => 'Simpan';

  @override
  String get adminFaceVerificationTitle => 'Verifikasi Wajah Admin';

  @override
  String get faceVerificationDesc =>
      'Untuk keamanan tambahan, silakan verifikasi wajah Anda sebelum mengakses dashboard admin.';

  @override
  String get faceVisibleInstruction => 'Pastikan wajah Anda terlihat jelas';

  @override
  String get sufficientLightingInstruction => 'Gunakan pencahayaan yang cukup';

  @override
  String get blinkToCaptureInstruction =>
      'Kedipkan mata untuk menangkap gambar';

  @override
  String get startVerification => 'Mulai Verifikasi';
}
