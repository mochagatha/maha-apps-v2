// App Configuration
class AppConfig {
  static const String appName = 'MAHA Apps';
  static const String appVersion = '2.0.0';
  
  // API Configuration
  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  
  // Cache Configuration
  static const Duration cacheExpiration = Duration(days: 7);
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
}
