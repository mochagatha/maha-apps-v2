// App constants
class AppConstants {
  // Storage keys
  static const String keyToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyRememberMe = 'remember_me';
  static const String keyBranchCode = 'branch_code';
  
  // Auth endpoints (V1 compatible)
  static const String endpointLogin = '/employee/login';
  static const String endpointLogout = '/auth/logout';
  static const String endpointRegister = '/employee/register';
  static const String endpointRefreshToken = '/employee/refresh-token';
  static const String endpointGetByToken = '/employee/get-by-token';

  // Home endpoints (V1 compatible)
  static const String endpointEmployeeProfile = '/employee/profile';
  static const String endpointEmployeeMenus = '/employee/employee-menu-application';
  static const String endpointNotificationCount = '/notification/count';
  
  // Profile endpoints (V1 compatible)
  static const String endpointUpdateProfile = '/employee/profile';
  static const String endpointUpdateProfilePicture = '/employee/employee-selfie';
  
  // Notification endpoints (V1 compatible)
  static const String endpointNotifications = '/employee/employee-notification/get-by-employee-id';
  static const String endpointMarkAsRead = '/employee-notification/read';
  static const String endpointMarkAllAsRead = '/employee/employee-notification/read-all-by-employee';
  static const String endpointDeleteAllRead = '/employee/employee-notification/delete-all-by-employee';
  
  // Absensi endpoints
  static const String endpointGetTodayEmployee = '/attendance/get-today-employee';
  static const String endpointGetTodayWorker = '/attendance/worker/get-today-worker';
  static const String endpointJobTitleMenu = '/employee/job-title-menu-application';
  static const String endpointSubmitAttendance = '/attendance/v2';
  static const String endpointSubmitAttendanceWorker = '/attendance/worker';
  
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
