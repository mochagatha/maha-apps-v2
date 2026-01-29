import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// Application name
  ///
  /// In id, this message translates to:
  /// **'MAHA Apps'**
  String get appName;

  /// Login button text
  ///
  /// In id, this message translates to:
  /// **'Masuk'**
  String get login;

  /// Register button text
  ///
  /// In id, this message translates to:
  /// **'Daftar disini'**
  String get register;

  /// Confirm button text
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi'**
  String get confirm;

  /// Validation message when field is empty
  ///
  /// In id, this message translates to:
  /// **'Semua kolom wajib diisi'**
  String get fieldRequired;

  /// Email field label
  ///
  /// In id, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In id, this message translates to:
  /// **'Kata Sandi'**
  String get password;

  /// Confirm password field label
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Kata Sandi'**
  String get confirmPassword;

  /// Fullname field label
  ///
  /// In id, this message translates to:
  /// **'Nama Lengkap'**
  String get fullname;

  /// Forgot password link
  ///
  /// In id, this message translates to:
  /// **'Lupa kata sandi?'**
  String get forgotPassword;

  /// Remember me checkbox
  ///
  /// In id, this message translates to:
  /// **'Tetap masuk'**
  String get rememberMe;

  /// Don't have account text
  ///
  /// In id, this message translates to:
  /// **'Belum punya akun?'**
  String get dontHaveAccount;

  /// Already have account text
  ///
  /// In id, this message translates to:
  /// **'Sudah punya akun?'**
  String get alreadyHaveAccount;

  /// Email field hint
  ///
  /// In id, this message translates to:
  /// **'Masukkan email anda...'**
  String get enterEmail;

  /// Password field hint
  ///
  /// In id, this message translates to:
  /// **'Masukkan kata sandi anda...'**
  String get enterPassword;

  /// Fullname field hint
  ///
  /// In id, this message translates to:
  /// **'Masukkan nama lengkap anda...'**
  String get enterFullname;

  /// Email required validation
  ///
  /// In id, this message translates to:
  /// **'Email tidak boleh kosong'**
  String get emailRequired;

  /// Email invalid validation
  ///
  /// In id, this message translates to:
  /// **'Format email tidak valid'**
  String get emailInvalid;

  /// Password required validation
  ///
  /// In id, this message translates to:
  /// **'Password tidak boleh kosong'**
  String get passwordRequired;

  /// Password minimum length validation
  ///
  /// In id, this message translates to:
  /// **'Password minimal 6 karakter'**
  String get passwordMinLength;

  /// Password not match validation
  ///
  /// In id, this message translates to:
  /// **'Password tidak sama'**
  String get passwordNotMatch;

  /// Fullname required validation
  ///
  /// In id, this message translates to:
  /// **'Nama lengkap tidak boleh kosong'**
  String get fullnameRequired;

  /// Create account button
  ///
  /// In id, this message translates to:
  /// **'Buat Akun'**
  String get createAccount;

  /// Create account page title
  ///
  /// In id, this message translates to:
  /// **'Buat Akun Baru'**
  String get createAccountTitle;

  /// Account type label
  ///
  /// In id, this message translates to:
  /// **'Jenis Akun'**
  String get accountType;

  /// Employee account type
  ///
  /// In id, this message translates to:
  /// **'Karyawan'**
  String get employee;

  /// Worker account type
  ///
  /// In id, this message translates to:
  /// **'Pekerja'**
  String get worker;

  /// Registration success title
  ///
  /// In id, this message translates to:
  /// **'Pendaftaran Berhasil!'**
  String get registrationSuccess;

  /// Registration success message
  ///
  /// In id, this message translates to:
  /// **'Silahkan login dengan akun yang telah didaftarkan'**
  String get registrationSuccessMessage;

  /// PIN verification dialog title
  ///
  /// In id, this message translates to:
  /// **'Masukkan Kode Verifikasi Perusahaan'**
  String get pinVerificationTitle;

  /// PIN verification dialog message
  ///
  /// In id, this message translates to:
  /// **'Masukkan kode verifikasi perusahaan yang telah diberikan HRD'**
  String get pinVerificationMessage;

  /// PIN invalid message
  ///
  /// In id, this message translates to:
  /// **'Kode verifikasi tidak valid'**
  String get pinInvalid;

  /// Terms and conditions title
  ///
  /// In id, this message translates to:
  /// **'Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi MAHA Apps Mobile'**
  String get termsAndConditionsTitle;

  /// Terms and conditions message
  ///
  /// In id, this message translates to:
  /// **'Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi merupakan ketentuan yang harus dibaca, dipahami, dan disetujui oleh pengguna sebelum mengakses atau menggunakan aplikasi MAHA Apps Mobile. Lihat selengkapnya di sini:'**
  String get termsAndConditionsMessage;

  /// Terms of use link
  ///
  /// In id, this message translates to:
  /// **'Syarat & Ketentuan Penggunaan'**
  String get termsOfUse;

  /// Privacy notice link
  ///
  /// In id, this message translates to:
  /// **'Pemberitahuan Privasi'**
  String get privacyNotice;

  /// Agree terms checkbox text
  ///
  /// In id, this message translates to:
  /// **'Dengan ini menyatakan Setuju, anda menerima segala isi Syarat & Ketentuan Penggunaan dan Pemberitahuan Privasi'**
  String get agreeTerms;

  /// I agree button
  ///
  /// In id, this message translates to:
  /// **'Saya Setuju'**
  String get iAgree;

  /// Copyright text
  ///
  /// In id, this message translates to:
  /// **'© Copyright IT Maha {year}'**
  String copyright(String year);

  /// Select role dropdown label
  ///
  /// In id, this message translates to:
  /// **'Pilih Role (Quick Fill)'**
  String get selectRole;

  /// Loading text
  ///
  /// In id, this message translates to:
  /// **'Sedang memuat...'**
  String get loading;

  /// Retry button
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get retry;

  /// Close button
  ///
  /// In id, this message translates to:
  /// **'Tutup'**
  String get close;

  /// Profile page title
  ///
  /// In id, this message translates to:
  /// **'Profil'**
  String get profile;

  /// Profile picture label
  ///
  /// In id, this message translates to:
  /// **'Foto Profil'**
  String get profilePicture;

  /// Profile points label
  ///
  /// In id, this message translates to:
  /// **'Poin saat ini'**
  String get profilePoints;

  /// Profile features section title
  ///
  /// In id, this message translates to:
  /// **'FITUR'**
  String get profileFeatures;

  /// Profile preferences section title
  ///
  /// In id, this message translates to:
  /// **'PREFERENSI'**
  String get profilePreferences;

  /// Personal data menu
  ///
  /// In id, this message translates to:
  /// **'Data Diri'**
  String get dataDiri;

  /// Education menu
  ///
  /// In id, this message translates to:
  /// **'Pendidikan'**
  String get education;

  /// Skill menu
  ///
  /// In id, this message translates to:
  /// **'Skill'**
  String get skill;

  /// Family menu
  ///
  /// In id, this message translates to:
  /// **'Keluarga'**
  String get family;

  /// Change password menu
  ///
  /// In id, this message translates to:
  /// **'Ubah Password'**
  String get changePassword;

  /// Secure account menu
  ///
  /// In id, this message translates to:
  /// **'Keamanan Akun'**
  String get secureAccount;

  /// Logout confirmation dialog title
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin keluar dari aplikasi?'**
  String get logoutConfirmTitle;

  /// Logout confirmation dialog message
  ///
  /// In id, this message translates to:
  /// **'Keluar dari aplikasi'**
  String get logoutConfirmMessage;

  /// Logout button label
  ///
  /// In id, this message translates to:
  /// **'Keluar'**
  String get logout;

  /// Logout confirmation part 1
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin '**
  String get logoutConfirmation1;

  /// Logout confirmation part 2 (bold)
  ///
  /// In id, this message translates to:
  /// **'keluar '**
  String get logoutConfirmation2;

  /// Logout confirmation part 3
  ///
  /// In id, this message translates to:
  /// **'dari aplikasi?'**
  String get logoutConfirmation3;

  /// Yes button
  ///
  /// In id, this message translates to:
  /// **'Ya'**
  String get yes;

  /// No button
  ///
  /// In id, this message translates to:
  /// **'Tidak'**
  String get no;

  /// Cancel button
  ///
  /// In id, this message translates to:
  /// **'Batal'**
  String get cancel;

  /// Points label
  ///
  /// In id, this message translates to:
  /// **'Poin'**
  String get points;

  /// Target reached message
  ///
  /// In id, this message translates to:
  /// **'Target tercapai 🎉'**
  String get targetReached;

  /// App version text
  ///
  /// In id, this message translates to:
  /// **'Versi Aplikasi: {version}'**
  String appVersion(String version);

  /// Rejected status dialog title
  ///
  /// In id, this message translates to:
  /// **'Data diri anda ditolak, Segera cek pemberitahuannya !'**
  String get statusRejectedTitle;

  /// Check details button
  ///
  /// In id, this message translates to:
  /// **'Lihat Keterangan'**
  String get checkDetails;

  /// Inactive status message
  ///
  /// In id, this message translates to:
  /// **'Akun Anda Nonaktif. Silahkan hubungi HRD Maha segera !'**
  String get statusInactive;

  /// Blacklisted status message
  ///
  /// In id, this message translates to:
  /// **'Akun masuk daftar hitam. Silahkan hubungi HRD Maha segera !'**
  String get statusBlacklisted;

  /// Contract unverified status message
  ///
  /// In id, this message translates to:
  /// **'Data Kontrak Anda Belum Diverifikasi. Silahkan hubungi HRD Maha segera !'**
  String get statusContractUnverified;

  /// Inaccessible status message
  ///
  /// In id, this message translates to:
  /// **'Akun anda tidak dapat diakses. Silahkan hubungi HRD Maha segera !'**
  String get statusInaccessible;

  /// Contact admin button
  ///
  /// In id, this message translates to:
  /// **'Hubungi Admin'**
  String get contactAdmin;

  /// No description provided for @contactAdminMessageInactive.
  ///
  /// In id, this message translates to:
  /// **'Halo admin, Kenapa akun saya nonaktif, Terima Kasih'**
  String get contactAdminMessageInactive;

  /// No description provided for @contactAdminMessageBlacklisted.
  ///
  /// In id, this message translates to:
  /// **'Halo admin, Kenapa akun saya masuk daftar hitam, Terima Kasih'**
  String get contactAdminMessageBlacklisted;

  /// No description provided for @contactAdminMessageContract.
  ///
  /// In id, this message translates to:
  /// **'Halo admin, Kenapa data kontrak saya belum diverifikasi, Terima Kasih'**
  String get contactAdminMessageContract;

  /// No description provided for @contactAdminMessageInaccessible.
  ///
  /// In id, this message translates to:
  /// **'Halo admin, Kenapa akun saya tidak dapat diakses mohon dibantu, Terima Kasih'**
  String get contactAdminMessageInaccessible;

  /// No description provided for @rejectStatusDetailsComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Detail Status Penolakan Segera Hadir'**
  String get rejectStatusDetailsComingSoon;

  /// No description provided for @menuAbsensi.
  ///
  /// In id, this message translates to:
  /// **'Absensi'**
  String get menuAbsensi;

  /// No description provided for @menuMengamati.
  ///
  /// In id, this message translates to:
  /// **'Mengamati'**
  String get menuMengamati;

  /// No description provided for @menuPersetujuan.
  ///
  /// In id, this message translates to:
  /// **'Persetujuan'**
  String get menuPersetujuan;

  /// No description provided for @menuRencanaKerja.
  ///
  /// In id, this message translates to:
  /// **'Rencana Kerja'**
  String get menuRencanaKerja;

  /// No description provided for @menuPermintaan.
  ///
  /// In id, this message translates to:
  /// **'Permintaan'**
  String get menuPermintaan;

  /// No description provided for @menuTugas.
  ///
  /// In id, this message translates to:
  /// **'Tugas'**
  String get menuTugas;

  /// No description provided for @menuPengajuan.
  ///
  /// In id, this message translates to:
  /// **'Pengajuan'**
  String get menuPengajuan;

  /// No description provided for @menuAdministrasi.
  ///
  /// In id, this message translates to:
  /// **'Administrasi'**
  String get menuAdministrasi;

  /// No description provided for @menuArsip.
  ///
  /// In id, this message translates to:
  /// **'Arsip'**
  String get menuArsip;

  /// No description provided for @menuDataAbsensi.
  ///
  /// In id, this message translates to:
  /// **'Data Absensi'**
  String get menuDataAbsensi;

  /// No description provided for @menuDataKaryawan.
  ///
  /// In id, this message translates to:
  /// **'Data Karyawan'**
  String get menuDataKaryawan;

  /// No description provided for @menuProyek.
  ///
  /// In id, this message translates to:
  /// **'Proyek'**
  String get menuProyek;

  /// No description provided for @menuAduan.
  ///
  /// In id, this message translates to:
  /// **'Aduan'**
  String get menuAduan;

  /// No description provided for @menuDataPayroll.
  ///
  /// In id, this message translates to:
  /// **'Data Payroll'**
  String get menuDataPayroll;

  /// No description provided for @menuKasir.
  ///
  /// In id, this message translates to:
  /// **'Kasir'**
  String get menuKasir;

  /// No description provided for @menuAkuntansi.
  ///
  /// In id, this message translates to:
  /// **'Akuntansi'**
  String get menuAkuntansi;

  /// No description provided for @menuRekrutmen.
  ///
  /// In id, this message translates to:
  /// **'Rekrutmen'**
  String get menuRekrutmen;

  /// No description provided for @menuPengaturan.
  ///
  /// In id, this message translates to:
  /// **'Pengaturan'**
  String get menuPengaturan;

  /// No description provided for @menuUpdateKontrak.
  ///
  /// In id, this message translates to:
  /// **'Update Kontrak'**
  String get menuUpdateKontrak;

  /// No description provided for @menuKpi.
  ///
  /// In id, this message translates to:
  /// **'Indikator Kinerja Utama (KPI)'**
  String get menuKpi;

  /// No description provided for @verificationErrorTitle.
  ///
  /// In id, this message translates to:
  /// **'Maaf Sebelumnya!'**
  String get verificationErrorTitle;

  /// No description provided for @verificationErrorPart1.
  ///
  /// In id, this message translates to:
  /// **'Akun Anda belum '**
  String get verificationErrorPart1;

  /// No description provided for @verificationErrorPart2.
  ///
  /// In id, this message translates to:
  /// **'terverifikasi'**
  String get verificationErrorPart2;

  /// No description provided for @verificationErrorPart3.
  ///
  /// In id, this message translates to:
  /// **'. Silahkan\nhubungi '**
  String get verificationErrorPart3;

  /// No description provided for @verificationErrorPart4.
  ///
  /// In id, this message translates to:
  /// **'HRD'**
  String get verificationErrorPart4;

  /// No description provided for @verificationErrorPart5.
  ///
  /// In id, this message translates to:
  /// **' Maha segera !'**
  String get verificationErrorPart5;

  /// No description provided for @targetReachedSimplified.
  ///
  /// In id, this message translates to:
  /// **'Target tercapai!'**
  String get targetReachedSimplified;

  /// Points not reached message
  ///
  /// In id, this message translates to:
  /// **'{remaining} Poin belum tercapai'**
  String pointsNotReached(int remaining);

  /// No description provided for @ePresensi.
  ///
  /// In id, this message translates to:
  /// **'E-Presensi'**
  String get ePresensi;

  /// No description provided for @pageNotFoundTitle.
  ///
  /// In id, this message translates to:
  /// **'Halaman Tidak Ditemukan'**
  String get pageNotFoundTitle;

  /// No description provided for @pageNotFoundMessage.
  ///
  /// In id, this message translates to:
  /// **'Halaman yang Anda cari tidak ditemukan atau fitur ini belum diimplementasikan.'**
  String get pageNotFoundMessage;

  /// No description provided for @back.
  ///
  /// In id, this message translates to:
  /// **'Kembali'**
  String get back;

  /// Change language menu
  ///
  /// In id, this message translates to:
  /// **'Ubah Bahasa'**
  String get changeLanguage;

  /// Select language dialog title
  ///
  /// In id, this message translates to:
  /// **'Pilih Bahasa'**
  String get selectLanguage;

  /// No description provided for @languageIndonesian.
  ///
  /// In id, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageIndonesian;

  /// No description provided for @languageEnglish.
  ///
  /// In id, this message translates to:
  /// **'Inggris'**
  String get languageEnglish;

  /// No description provided for @featureComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Fitur segera hadir!'**
  String get featureComingSoon;

  /// No description provided for @menuPenempatanKerja.
  ///
  /// In id, this message translates to:
  /// **'Penempatan kerja'**
  String get menuPenempatanKerja;

  /// No description provided for @menuHariLibur.
  ///
  /// In id, this message translates to:
  /// **'Hari Libur & Cuti Bersama'**
  String get menuHariLibur;

  /// No description provided for @menuHirarkiOffice.
  ///
  /// In id, this message translates to:
  /// **'Hirarki Office'**
  String get menuHirarkiOffice;

  /// No description provided for @menuLembur.
  ///
  /// In id, this message translates to:
  /// **'Lembur'**
  String get menuLembur;

  /// No description provided for @menuTindakanKaryawan.
  ///
  /// In id, this message translates to:
  /// **'Tindakan Karyawan'**
  String get menuTindakanKaryawan;

  /// No description provided for @menuBpjs.
  ///
  /// In id, this message translates to:
  /// **'BPJS'**
  String get menuBpjs;

  /// No description provided for @menuPph21.
  ///
  /// In id, this message translates to:
  /// **'PPH 21'**
  String get menuPph21;

  /// No description provided for @menuJamKerja.
  ///
  /// In id, this message translates to:
  /// **'Jam Kerja'**
  String get menuJamKerja;

  /// No description provided for @menuFormatDanDraf.
  ///
  /// In id, this message translates to:
  /// **'Format dan Draf'**
  String get menuFormatDanDraf;

  /// No description provided for @menuAksesLayar.
  ///
  /// In id, this message translates to:
  /// **'Akses Layar'**
  String get menuAksesLayar;

  /// No description provided for @menuHakAksesMenu.
  ///
  /// In id, this message translates to:
  /// **'Hak Akses Menu'**
  String get menuHakAksesMenu;

  /// No description provided for @menuPelacakanJamKerja.
  ///
  /// In id, this message translates to:
  /// **'Pelacakan Jam Kerja'**
  String get menuPelacakanJamKerja;

  /// No description provided for @menuStrukturOrganisasi.
  ///
  /// In id, this message translates to:
  /// **'Struktur Organisasi'**
  String get menuStrukturOrganisasi;

  /// No description provided for @redeemPoints.
  ///
  /// In id, this message translates to:
  /// **'Tukar Poin'**
  String get redeemPoints;

  /// No description provided for @performance.
  ///
  /// In id, this message translates to:
  /// **'Performa'**
  String get performance;

  /// No description provided for @salarySlip.
  ///
  /// In id, this message translates to:
  /// **'Slip Gaji'**
  String get salarySlip;

  /// No description provided for @debtSlip.
  ///
  /// In id, this message translates to:
  /// **'Slip Hutang'**
  String get debtSlip;

  /// No description provided for @resignation.
  ///
  /// In id, this message translates to:
  /// **'Pengunduran Diri'**
  String get resignation;

  /// No description provided for @ok.
  ///
  /// In id, this message translates to:
  /// **'Oke'**
  String get ok;

  /// No description provided for @verificationJobLevelTitle.
  ///
  /// In id, this message translates to:
  /// **'Data Tingkatan Pekerjaan'**
  String get verificationJobLevelTitle;

  /// No description provided for @dailyWorker.
  ///
  /// In id, this message translates to:
  /// **'Pekerja Harian'**
  String get dailyWorker;

  /// No description provided for @dailyWorkerVerificationComingSoon.
  ///
  /// In id, this message translates to:
  /// **'Fitur Verifikasi Data Pekerja Harian akan segera hadir!'**
  String get dailyWorkerVerificationComingSoon;

  /// No description provided for @companyCodeTitle.
  ///
  /// In id, this message translates to:
  /// **'Kode Perusahaan'**
  String get companyCodeTitle;

  /// No description provided for @failedToLoadCompanyCode.
  ///
  /// In id, this message translates to:
  /// **'Gagal Memuat Kode Perusahaan'**
  String get failedToLoadCompanyCode;

  /// No description provided for @companyCodeInstruction.
  ///
  /// In id, this message translates to:
  /// **'Gunakan Kode Perusahaan yang dikelola oleh sistem dan akan berganti secara otomatis'**
  String get companyCodeInstruction;

  /// No description provided for @refreshCodeTooltip.
  ///
  /// In id, this message translates to:
  /// **'Refresh Kode'**
  String get refreshCodeTooltip;

  /// No description provided for @employeeVerificationTitle.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Data Karyawan'**
  String get employeeVerificationTitle;

  /// No description provided for @featureUnderDevelopment.
  ///
  /// In id, this message translates to:
  /// **'Fitur Dalam Pengembangan'**
  String get featureUnderDevelopment;

  /// No description provided for @employeeVerificationDevMessage.
  ///
  /// In id, this message translates to:
  /// **'Halaman Verifikasi Data Karyawan sedang dalam tahap pengembangan. Fitur ini akan menampilkan daftar karyawan yang perlu diverifikasi dengan tab filter status.'**
  String get employeeVerificationDevMessage;

  /// No description provided for @menuVerifikasiData.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Data'**
  String get menuVerifikasiData;

  /// No description provided for @menuPerjanjianKerja.
  ///
  /// In id, this message translates to:
  /// **'Perjanjian Kerja'**
  String get menuPerjanjianKerja;

  /// No description provided for @menuAktivasiBpjs.
  ///
  /// In id, this message translates to:
  /// **'Aktivasi BPJS'**
  String get menuAktivasiBpjs;

  /// No description provided for @menuKodePerusahaan.
  ///
  /// In id, this message translates to:
  /// **'Kode Perusahaan'**
  String get menuKodePerusahaan;

  /// No description provided for @recruitmentTitle.
  ///
  /// In id, this message translates to:
  /// **'Rekrutmen'**
  String get recruitmentTitle;

  /// No description provided for @recruitmentEmpty.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada menu rekrutmen tersedia'**
  String get recruitmentEmpty;

  /// No description provided for @errorOccurred.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan'**
  String get errorOccurred;

  /// Feature coming soon with dynamic label
  ///
  /// In id, this message translates to:
  /// **'Fitur {label} akan segera hadir!'**
  String featureComingSoonDynamic(String label);

  /// No description provided for @underMonitoring.
  ///
  /// In id, this message translates to:
  /// **'Kamu sedang dalam\npemantauan nih!'**
  String get underMonitoring;

  /// No description provided for @showChart.
  ///
  /// In id, this message translates to:
  /// **'Tampilkan Bagan'**
  String get showChart;

  /// No description provided for @archive.
  ///
  /// In id, this message translates to:
  /// **'Arsip'**
  String get archive;

  /// No description provided for @deleteRole.
  ///
  /// In id, this message translates to:
  /// **'Hapus Role'**
  String get deleteRole;

  /// No description provided for @deleteStructureRoleTitle.
  ///
  /// In id, this message translates to:
  /// **'Hapus Role Struktur'**
  String get deleteStructureRoleTitle;

  /// No description provided for @deleteStructureRoleMessage.
  ///
  /// In id, this message translates to:
  /// **'Apakah Anda yakin ingin menghapus role ini?'**
  String get deleteStructureRoleMessage;

  /// No description provided for @jobLevelList.
  ///
  /// In id, this message translates to:
  /// **'Daftar Tingkatan Pekerjaan'**
  String get jobLevelList;

  /// No description provided for @select.
  ///
  /// In id, this message translates to:
  /// **'Pilih'**
  String get select;

  /// No description provided for @sorryBeforehand.
  ///
  /// In id, this message translates to:
  /// **'Maaf, Sebelumnya...'**
  String get sorryBeforehand;

  /// No description provided for @confirmAddJobLevelStructure.
  ///
  /// In id, this message translates to:
  /// **'Apakah anda yakin ingin menambahkan Daftar Tingkatan Pekerjaan ke struktur utama ?'**
  String get confirmAddJobLevelStructure;

  /// No description provided for @successExclamation.
  ///
  /// In id, this message translates to:
  /// **'Berhasil!!'**
  String get successExclamation;

  /// No description provided for @jobLevelAddedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Daftar tingkatan pekerjaan berhasil di Tambahkan'**
  String get jobLevelAddedSuccess;

  /// No description provided for @structureNotFound.
  ///
  /// In id, this message translates to:
  /// **'Struktur tidak ditemukan'**
  String get structureNotFound;

  /// No description provided for @failedToAddRole.
  ///
  /// In id, this message translates to:
  /// **'Gagal menambahkan role'**
  String get failedToAddRole;

  /// No description provided for @roleDeletedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Role berhasil dihapus'**
  String get roleDeletedSuccess;

  /// No description provided for @noRolesAvailable.
  ///
  /// In id, this message translates to:
  /// **'Tidak ada role yang tersedia'**
  String get noRolesAvailable;

  /// No description provided for @allRolesAdded.
  ///
  /// In id, this message translates to:
  /// **'Semua role sudah ditambahkan'**
  String get allRolesAdded;

  /// No description provided for @addMainStructureLevel.
  ///
  /// In id, this message translates to:
  /// **'+ Tingkatan Struktur Utama'**
  String get addMainStructureLevel;

  /// No description provided for @mainStructure.
  ///
  /// In id, this message translates to:
  /// **'Struktur Utama'**
  String get mainStructure;

  /// No description provided for @emptyStructureTitle.
  ///
  /// In id, this message translates to:
  /// **'Anda belum memiliki Struktur Utama'**
  String get emptyStructureTitle;

  /// No description provided for @emptyStructureMessage.
  ///
  /// In id, this message translates to:
  /// **'Anda harus menambahkan struktur anda terlebih\ndahulu.'**
  String get emptyStructureMessage;

  /// No description provided for @welcomeGreetingTitle.
  ///
  /// In id, this message translates to:
  /// **'Selamat Bergabung !'**
  String get welcomeGreetingTitle;

  /// No description provided for @welcomeGreetingMessage.
  ///
  /// In id, this message translates to:
  /// **'Semoga Anda dapat memberikan kontribusi terbaik bagi perusahaan PT. Maha Akbar Sejahtera.'**
  String get welcomeGreetingMessage;

  /// No description provided for @director.
  ///
  /// In id, this message translates to:
  /// **'Direktur'**
  String get director;

  /// No description provided for @next.
  ///
  /// In id, this message translates to:
  /// **'Selanjutnya'**
  String get next;

  /// No description provided for @companyRegulationsTitle.
  ///
  /// In id, this message translates to:
  /// **'Peraturan Perusahaan !'**
  String get companyRegulationsTitle;

  /// No description provided for @regulationPromptMessage.
  ///
  /// In id, this message translates to:
  /// **'Sebelum Anda melanjutkan ke tahap pengisian data. Harap baca terlebih dahulu peraturan PT. Maha Akbar Sejahtera...!'**
  String get regulationPromptMessage;

  /// No description provided for @agreeToRegulations.
  ///
  /// In id, this message translates to:
  /// **'Dengan ini saya menyatakan bahwa saya menyetujui seluruh peraturan perusahaan'**
  String get agreeToRegulations;

  /// No description provided for @download.
  ///
  /// In id, this message translates to:
  /// **'Unduh'**
  String get download;

  /// No description provided for @continueAction.
  ///
  /// In id, this message translates to:
  /// **'Lanjutkan'**
  String get continueAction;

  /// No description provided for @completePersonalDataTitle.
  ///
  /// In id, this message translates to:
  /// **'Lengkapi Data diri Anda !'**
  String get completePersonalDataTitle;

  /// No description provided for @dataCompletionTimeMessage.
  ///
  /// In id, this message translates to:
  /// **'Dalam pengisian formulir ini, Anda membutuhkan waktu 10 Menit. Harap diisi dengan sejujurnya yah !'**
  String get dataCompletionTimeMessage;

  /// No description provided for @spirit.
  ///
  /// In id, this message translates to:
  /// **'Semangat'**
  String get spirit;

  /// No description provided for @companySlogan.
  ///
  /// In id, this message translates to:
  /// **'Be Great, Be Integrated'**
  String get companySlogan;

  /// No description provided for @verificationFailed.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Gagal'**
  String get verificationFailed;

  /// No description provided for @tryAgain.
  ///
  /// In id, this message translates to:
  /// **'Coba Lagi'**
  String get tryAgain;

  /// No description provided for @adminDataNotFound.
  ///
  /// In id, this message translates to:
  /// **'Data admin tidak ditemukan.'**
  String get adminDataNotFound;

  /// No description provided for @faceVerification.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Wajah'**
  String get faceVerification;

  /// No description provided for @blinkInstruction.
  ///
  /// In id, this message translates to:
  /// **'Kedipkan mata untuk menangkap gambar wajah'**
  String get blinkInstruction;

  /// No description provided for @sendingData.
  ///
  /// In id, this message translates to:
  /// **'Mengirim data...'**
  String get sendingData;

  /// No description provided for @resetYourPassword.
  ///
  /// In id, this message translates to:
  /// **'Reset Kata Sandi Anda'**
  String get resetYourPassword;

  /// No description provided for @enterEmailToResetPassword.
  ///
  /// In id, this message translates to:
  /// **'Masukkan E-mail yang pernah terdaftar untuk melanjutkan reset password'**
  String get enterEmailToResetPassword;

  /// No description provided for @emailHintExample.
  ///
  /// In id, this message translates to:
  /// **'contoh : user@mahasejahtera.com'**
  String get emailHintExample;

  /// No description provided for @enterValidVerificationCode.
  ///
  /// In id, this message translates to:
  /// **'Mohon masukkan kode verifikasi yang valid'**
  String get enterValidVerificationCode;

  /// No description provided for @verifyingOtp.
  ///
  /// In id, this message translates to:
  /// **'Memverifikasi kode OTP...'**
  String get verifyingOtp;

  /// No description provided for @otpIncorrect.
  ///
  /// In id, this message translates to:
  /// **'Kode OTP Salah'**
  String get otpIncorrect;

  /// No description provided for @otpIncorrectMessage.
  ///
  /// In id, this message translates to:
  /// **'Kode OTP yang Anda masukkan tidak sesuai. Silakan coba lagi.'**
  String get otpIncorrectMessage;

  /// No description provided for @unexpectedErrorRetry.
  ///
  /// In id, this message translates to:
  /// **'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.'**
  String get unexpectedErrorRetry;

  /// No description provided for @enterVerificationCode.
  ///
  /// In id, this message translates to:
  /// **'Masukkan Kode Verifikasi'**
  String get enterVerificationCode;

  /// No description provided for @verificationCodeSentToEmail.
  ///
  /// In id, this message translates to:
  /// **'Kode verifikasi telah dikirim melalui e-mail ke '**
  String get verificationCodeSentToEmail;

  /// No description provided for @verify.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi'**
  String get verify;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In id, this message translates to:
  /// **'Tidak menerima kode verifikasi? '**
  String get didNotReceiveCode;

  /// No description provided for @resend.
  ///
  /// In id, this message translates to:
  /// **'Kirim Ulang'**
  String get resend;

  /// No description provided for @resendIn.
  ///
  /// In id, this message translates to:
  /// **'Kirim Ulang dalam {time}'**
  String resendIn(Object time);

  /// No description provided for @resendingOtp.
  ///
  /// In id, this message translates to:
  /// **'Mengirim ulang OTP...'**
  String get resendingOtp;

  /// No description provided for @otpResentSuccess.
  ///
  /// In id, this message translates to:
  /// **'Kode OTP berhasil dikirim ulang!'**
  String get otpResentSuccess;

  /// No description provided for @otpResendFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal Mengirim OTP'**
  String get otpResendFailed;

  /// No description provided for @otpResendFailedMessage.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengirim ulang kode OTP. Silakan coba lagi.'**
  String get otpResendFailedMessage;

  /// No description provided for @verificationDataNotFound.
  ///
  /// In id, this message translates to:
  /// **'Data Verifikasi Tidak Ditemukan'**
  String get verificationDataNotFound;

  /// No description provided for @pleaseVerifyOtpFirst.
  ///
  /// In id, this message translates to:
  /// **'Silakan lakukan verifikasi OTP terlebih dahulu.'**
  String get pleaseVerifyOtpFirst;

  /// No description provided for @changeYourPassword.
  ///
  /// In id, this message translates to:
  /// **'Ubah Kata Sandi Anda'**
  String get changeYourPassword;

  /// No description provided for @changePasswordInstruction.
  ///
  /// In id, this message translates to:
  /// **'Silahkan ubah kata sandi lama Anda untuk keamanan Akun'**
  String get changePasswordInstruction;

  /// No description provided for @enterNewPassword.
  ///
  /// In id, this message translates to:
  /// **'Masukkan Kata Sandi Baru'**
  String get enterNewPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In id, this message translates to:
  /// **'Konfirmasi Kata Sandi Baru'**
  String get confirmNewPassword;

  /// No description provided for @changingPassword.
  ///
  /// In id, this message translates to:
  /// **'Mengubah kata sandi...'**
  String get changingPassword;

  /// No description provided for @success.
  ///
  /// In id, this message translates to:
  /// **'Berhasil'**
  String get success;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In id, this message translates to:
  /// **'Kata sandi Anda telah berhasil diubah!'**
  String get passwordChangedSuccess;

  /// No description provided for @passwordChangeFailed.
  ///
  /// In id, this message translates to:
  /// **'Gagal Mengubah Kata Sandi'**
  String get passwordChangeFailed;

  /// No description provided for @passwordChangeFailedMessage.
  ///
  /// In id, this message translates to:
  /// **'Gagal mengubah kata sandi. Silakan coba lagi.'**
  String get passwordChangeFailedMessage;

  /// No description provided for @save.
  ///
  /// In id, this message translates to:
  /// **'Simpan'**
  String get save;

  /// No description provided for @adminFaceVerificationTitle.
  ///
  /// In id, this message translates to:
  /// **'Verifikasi Wajah Admin'**
  String get adminFaceVerificationTitle;

  /// No description provided for @faceVerificationDesc.
  ///
  /// In id, this message translates to:
  /// **'Untuk keamanan tambahan, silakan verifikasi wajah Anda sebelum mengakses dashboard admin.'**
  String get faceVerificationDesc;

  /// No description provided for @faceVisibleInstruction.
  ///
  /// In id, this message translates to:
  /// **'Pastikan wajah Anda terlihat jelas'**
  String get faceVisibleInstruction;

  /// No description provided for @sufficientLightingInstruction.
  ///
  /// In id, this message translates to:
  /// **'Gunakan pencahayaan yang cukup'**
  String get sufficientLightingInstruction;

  /// No description provided for @blinkToCaptureInstruction.
  ///
  /// In id, this message translates to:
  /// **'Kedipkan mata untuk menangkap gambar'**
  String get blinkToCaptureInstruction;

  /// No description provided for @startVerification.
  ///
  /// In id, this message translates to:
  /// **'Mulai Verifikasi'**
  String get startVerification;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
