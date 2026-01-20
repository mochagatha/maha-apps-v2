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
  /// **'Monitoring KPI'**
  String get menuKpi;
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
