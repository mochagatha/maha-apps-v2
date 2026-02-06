// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MAHA Apps';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register here';

  @override
  String get confirm => 'Confirm';

  @override
  String get fieldRequired => 'All fields are required';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get fullname => 'Full Name';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get enterEmail => 'Enter your email...';

  @override
  String get enterPassword => 'Enter your password...';

  @override
  String get enterFullname => 'Enter your full name...';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email format';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordNotMatch => 'Passwords do not match';

  @override
  String get fullnameRequired => 'Full name is required';

  @override
  String get createAccount => 'Create Account';

  @override
  String get createAccountTitle => 'Create New Account';

  @override
  String get accountType => 'Account Type';

  @override
  String get employee => 'Employee';

  @override
  String get worker => 'Worker';

  @override
  String get registrationSuccess => 'Registration Successful!';

  @override
  String get registrationSuccessMessage =>
      'Please login with your registered account';

  @override
  String get pinVerificationTitle => 'Enter Company Verification Code';

  @override
  String get pinVerificationMessage =>
      'Enter the company verification code provided by HRD';

  @override
  String get pinInvalid => 'Invalid verification code';

  @override
  String get termsAndConditionsTitle =>
      'Terms & Conditions and Privacy Notice of MAHA Apps Mobile';

  @override
  String get termsAndConditionsMessage =>
      'Terms & Conditions and Privacy Notice are terms that must be read, understood, and agreed upon by users before accessing or using the MAHA Apps Mobile application. See more here:';

  @override
  String get termsOfUse => 'Terms & Conditions';

  @override
  String get privacyNotice => 'Privacy Notice';

  @override
  String get agreeTerms =>
      'By agreeing, you accept all the contents of the Terms & Conditions and Privacy Notice';

  @override
  String get iAgree => 'I Agree';

  @override
  String copyright(String year) {
    return '© Copyright IT Maha $year';
  }

  @override
  String get selectRole => 'Select Role (Quick Fill)';

  @override
  String get loading => 'Loading...';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get profile => 'Profile';

  @override
  String get profilePicture => 'Profile Picture';

  @override
  String get profilePoints => 'Current Points';

  @override
  String get profileFeatures => 'FEATURES';

  @override
  String get profilePreferences => 'PREFERENCES';

  @override
  String get dataDiri => 'Personal Data';

  @override
  String get education => 'Education';

  @override
  String get skill => 'Skills';

  @override
  String get family => 'Family';

  @override
  String get changePassword => 'Change Password';

  @override
  String get secureAccount => 'Account Security';

  @override
  String get logoutConfirmTitle => 'Are you sure you want to log out?';

  @override
  String get logoutConfirmMessage => 'Log out from application';

  @override
  String get logout => 'Logout';

  @override
  String get logoutConfirmation1 => 'Are you sure you want to ';

  @override
  String get logoutConfirmation2 => 'logout ';

  @override
  String get logoutConfirmation3 => 'from the application?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get cancel => 'Cancel';

  @override
  String get points => 'Points';

  @override
  String get targetReached => 'Target reached 🎉';

  @override
  String appVersion(String version) {
    return 'App Version: $version';
  }

  @override
  String get statusRejectedTitle =>
      'Your data has been rejected, check the notification immediately!';

  @override
  String get checkDetails => 'Check Details';

  @override
  String get statusInactive =>
      'Your account is inactive. Please contact HRD Maha immediately!';

  @override
  String get statusBlacklisted =>
      'Account blacklisted. Please contact HRD Maha immediately!';

  @override
  String get statusContractUnverified =>
      'Your contract data has not been verified. Please contact HRD Maha immediately!';

  @override
  String get statusInaccessible =>
      'Your account is inaccessible. Please contact HRD Maha immediately!';

  @override
  String get contactAdmin => 'Contact Admin';

  @override
  String get contactAdminMessageInactive =>
      'Hello admin, Why is my account inactive, Thank You';

  @override
  String get contactAdminMessageBlacklisted =>
      'Hello admin, Why is my account blacklisted, Thank You';

  @override
  String get contactAdminMessageContract =>
      'Hello admin, Why is my contract data not verified, Thank You';

  @override
  String get contactAdminMessageInaccessible =>
      'Hello admin, Why is my account inaccessible please help, Thank You';

  @override
  String get rejectStatusDetailsComingSoon =>
      'Reject Status Details Coming Soon';

  @override
  String get menuAbsensi => 'Attendance';

  @override
  String get menuMengamati => 'Monitoring';

  @override
  String get menuPersetujuan => 'Approval';

  @override
  String get menuRencanaKerja => 'Work Plan';

  @override
  String get menuPermintaan => 'Request';

  @override
  String get menuTugas => 'Task';

  @override
  String get menuPengajuan => 'Submission';

  @override
  String get menuAdministrasi => 'Administration';

  @override
  String get menuArsip => 'Archive';

  @override
  String get menuDataAbsensi => 'Attendance Data';

  @override
  String get menuDataKaryawan => 'Employee Data';

  @override
  String get menuProyek => 'Project';

  @override
  String get menuAduan => 'Complaint';

  @override
  String get menuDataPayroll => 'Payroll Data';

  @override
  String get menuKasir => 'Cashier';

  @override
  String get menuAkuntansi => 'Accounting';

  @override
  String get menuRekrutmen => 'Recruitment';

  @override
  String get menuPengaturan => 'Settings';

  @override
  String get menuUpdateKontrak => 'Update Contract';

  @override
  String get menuKpi => 'Key Performance Indicator (KPI)';

  @override
  String get verificationErrorTitle => 'Sorry!';

  @override
  String get verificationErrorPart1 => 'Your account is not ';

  @override
  String get verificationErrorPart2 => 'verified';

  @override
  String get verificationErrorPart3 => '. Please\ncontact ';

  @override
  String get verificationErrorPart4 => 'HRD';

  @override
  String get verificationErrorPart5 => ' Maha immediately!';

  @override
  String get targetReachedSimplified => 'Target reached!';

  @override
  String pointsNotReached(int remaining) {
    return '$remaining Points not reached';
  }

  @override
  String get ePresensi => 'E-Attendance';

  @override
  String get pageNotFoundTitle => 'Page Not Found';

  @override
  String get pageNotFoundMessage =>
      'The page you are looking for was not found or this feature has not been implemented yet.';

  @override
  String get back => 'Back';

  @override
  String get changeLanguage => 'Change Language';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get languageIndonesian => 'Indonesian';

  @override
  String get languageEnglish => 'English';

  @override
  String get featureComingSoon => 'Feature coming soon!';

  @override
  String get menuPenempatanKerja => 'Placement and Working Hours';

  @override
  String get menuHariLibur => 'Holidays & Joint Leave';

  @override
  String get menuHirarkiOffice => 'Office Hierarchy';

  @override
  String get menuLembur => 'Overtime';

  @override
  String get menuTindakanKaryawan => 'Employee Action';

  @override
  String get menuBpjs => 'BPJS';

  @override
  String get menuPph21 => 'PPH 21';

  @override
  String get menuJamKerja => 'Working Hours';

  @override
  String get menuFormatDanDraf => 'Format and Draft';

  @override
  String get menuAksesLayar => 'Screen Access';

  @override
  String get menuHakAksesMenu => 'Menu Access Rights';

  @override
  String get menuPelacakanJamKerja => 'Working Hours Tracking';

  @override
  String get menuStrukturOrganisasi => 'Organizational Structure';

  @override
  String get redeemPoints => 'Redeem Points';

  @override
  String get performance => 'Performance';

  @override
  String get salarySlip => 'Salary Slip';

  @override
  String get debtSlip => 'Debt Slip';

  @override
  String get resignation => 'Resignation';

  @override
  String get ok => 'OK';

  @override
  String get verificationJobLevelTitle => 'Job Level Data';

  @override
  String get dailyWorker => 'Daily Worker';

  @override
  String get dailyWorkerVerificationComingSoon =>
      'Daily Worker Data Verification feature coming soon!';

  @override
  String get companyCodeTitle => 'Company Code';

  @override
  String get failedToLoadCompanyCode => 'Failed to Load Company Code';

  @override
  String get companyCodeInstruction =>
      'Use the Company Code managed by the system which will change automatically';

  @override
  String get refreshCodeTooltip => 'Refresh Code';

  @override
  String get employeeVerificationTitle => 'Employee Data Verification';

  @override
  String get featureUnderDevelopment => 'Feature Under Development';

  @override
  String get employeeVerificationDevMessage =>
      'Employee Data Verification page is under development. This feature will display a list of employees to verify with status filter tabs.';

  @override
  String get menuVerifikasiData => 'Data Verification';

  @override
  String get menuPerjanjianKerja => 'Employment Agreement';

  @override
  String get menuAktivasiBpjs => 'BPJS Activation';

  @override
  String get menuKodePerusahaan => 'Company Code';

  @override
  String get recruitmentTitle => 'Recruitment';

  @override
  String get recruitmentEmpty => 'No recruitment menu available';

  @override
  String get errorOccurred => 'An error occurred';

  @override
  String featureComingSoonDynamic(String label) {
    return 'Feature $label coming soon!';
  }

  @override
  String get underMonitoring => 'You are under\nmonitoring!';

  @override
  String get showChart => 'Show Chart';

  @override
  String get archive => 'Archive';

  @override
  String get delete => 'Delete';

  @override
  String get deleteRole => 'Delete Role';

  @override
  String get deleteStructureRoleTitle => 'Delete Role Structure';

  @override
  String get deleteStructureRoleMessage =>
      'Are you sure you want to delete this role?';

  @override
  String get jobLevelList => 'Job Level List';

  @override
  String get select => 'Select';

  @override
  String get sorryBeforehand => 'Sorry...';

  @override
  String get confirmAddJobLevelStructure =>
      'Are you sure you want to add the Job Level List to the main structure?';

  @override
  String get successExclamation => 'Success!!';

  @override
  String get jobLevelAddedSuccess => 'Job level list successfully added';

  @override
  String get structureNotFound => 'Structure not found';

  @override
  String get failedToAddRole => 'Failed to add role';

  @override
  String get roleDeletedSuccess => 'Role successfully deleted';

  @override
  String get noRolesAvailable => 'No roles available';

  @override
  String get allRolesAdded => 'All roles have been added';

  @override
  String get addMainStructureLevel => '+ Main Structure Level';

  @override
  String get mainStructure => 'Main Structure';

  @override
  String get emptyStructureTitle => 'You do not have a Main Structure yet';

  @override
  String get emptyStructureMessage => 'You must add your structure first.';

  @override
  String get welcomeGreetingTitle => 'Welcome Aboard!';

  @override
  String get welcomeGreetingMessage =>
      'We hope you can give your best contribution to PT. Maha Akbar Sejahtera.';

  @override
  String get director => 'Director';

  @override
  String get next => 'Next';

  @override
  String get companyRegulationsTitle => 'Company Regulations!';

  @override
  String get regulationPromptMessage =>
      'Before you proceed to data entry. Please read PT. Maha Akbar Sejahtera regulations first...!';

  @override
  String get agreeToRegulations =>
      'I hereby declare that I agree to all company regulations';

  @override
  String get download => 'Download';

  @override
  String get continueAction => 'Continue';

  @override
  String get completePersonalDataTitle => 'Complete your Personal Data!';

  @override
  String get dataCompletionTimeMessage =>
      'Filling out this form will take about 10 Minutes. Please fill it out truthfully!';

  @override
  String get spirit => 'Cheer up';

  @override
  String get companySlogan => 'Be Great, Be Integrated';

  @override
  String get verificationFailed => 'Verification Failed';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get adminDataNotFound => 'Admin data not found.';

  @override
  String get faceVerification => 'Face Verification';

  @override
  String get blinkInstruction => 'Blink your eyes to capture face image';

  @override
  String get sendingData => 'Sending data...';

  @override
  String get resetYourPassword => 'Reset Your Password';

  @override
  String get enterEmailToResetPassword =>
      'Enter your registered email to proceed with password reset';

  @override
  String get emailHintExample => 'example: user@mahasejahtera.com';

  @override
  String get enterValidVerificationCode =>
      'Please enter a valid verification code';

  @override
  String get verifyingOtp => 'Verifying OTP code...';

  @override
  String get otpIncorrect => 'Incorrect OTP Code';

  @override
  String get otpIncorrectMessage =>
      'The OTP code you entered is incorrect. Please try again.';

  @override
  String get unexpectedErrorRetry =>
      'An unexpected error occurred. Please try again.';

  @override
  String get enterVerificationCode => 'Enter Verification Code';

  @override
  String get verificationCodeSentToEmail =>
      'Verification code has been sent via email to ';

  @override
  String get verify => 'Verify';

  @override
  String get didNotReceiveCode => 'Didn\'t receive verification code? ';

  @override
  String get resend => 'Resend';

  @override
  String resendIn(Object time) {
    return 'Resend in $time';
  }

  @override
  String get resendingOtp => 'Resending OTP...';

  @override
  String get otpResentSuccess => 'OTP code resent successfully!';

  @override
  String get otpResendFailed => 'Failed to Send OTP';

  @override
  String get otpResendFailedMessage =>
      'Failed to resend OTP code. Please try again.';

  @override
  String get verificationDataNotFound => 'Verification Data Not Found';

  @override
  String get pleaseVerifyOtpFirst => 'Please verify OTP first.';

  @override
  String get changeYourPassword => 'Change Your Password';

  @override
  String get changePasswordInstruction =>
      'Please change your old password for account security';

  @override
  String get enterNewPassword => 'Enter New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get changingPassword => 'Changing password...';

  @override
  String get success => 'Success';

  @override
  String get passwordChangedSuccess =>
      'Your password has been successfully changed!';

  @override
  String get passwordChangeFailed => 'Failed to Change Password';

  @override
  String get passwordChangeFailedMessage =>
      'Failed to change password. Please try again.';

  @override
  String get save => 'Save';

  @override
  String get adminFaceVerificationTitle => 'Admin Face Verification';

  @override
  String get faceVerificationDesc =>
      'For additional security, please verify your face before accessing the admin dashboard.';

  @override
  String get faceVisibleInstruction => 'Ensure your face is clearly visible';

  @override
  String get sufficientLightingInstruction => 'Use sufficient lighting';

  @override
  String get blinkToCaptureInstruction => 'Blink to capture image';

  @override
  String get startVerification => 'Start Verification';
}
