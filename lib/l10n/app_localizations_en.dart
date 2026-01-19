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
  String get register => 'Register';

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
}
