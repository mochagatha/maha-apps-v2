// Environment Configuration
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get baseUrlPublic => dotenv.env['BASE_URL_PUBLIC'] ?? '';

  // Add other environment variables as needed
  static bool get isProduction => dotenv.env['ENVIRONMENT'] == 'production';
  static bool get isDevelopment => dotenv.env['ENVIRONMENT'] == 'development';

  static Future<void> load() async {
    await dotenv.load(fileName: '.env');
  }
}
