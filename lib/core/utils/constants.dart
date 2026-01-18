// App constants
class AppConstants {
  // Storage keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyRememberMe = 'remember_me';
  static const String keyBranchCode = 'branch_code';
  
  // Auth endpoints
  static const String endpointLogin = '/auth/login';
  static const String endpointLogout = '/auth/logout';
  static const String endpointRegister = '/auth/register';

  // Home endpoints
  static const String endpointEmployeeProfile = '/employee/profile';
  static const String endpointEmployeeMenus = '/menu/employee';
  static const String endpointNotificationCount = '/notification/count';
  static const String endpointRefreshToken = '/auth/refresh';
  
  // Error messages
  static const String errorNoInternet = 'No internet connection. Please check your network.';
  static const String errorServerError = 'Server error. Please try again later.';
  static const String errorUnknown = 'An unexpected error occurred.';
  static const String errorTimeout = 'Connection timeout. Please try again.';
  
  // Success messages
  static const String successLogin = 'Login successful';
  static const String successLogout = 'Logout successful';
  static const String successRegister = 'Registration successful';
}
