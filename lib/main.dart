import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';
import 'features/authentication/presentation/providers/forgot_password_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/profile/presentation/providers/profile_provider.dart';
import 'features/biodata/presentation/providers/selfie_provider.dart';
import 'features/screen_security/presentation/providers/screen_security_provider.dart';
import 'core/providers/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize dependency injection
  await di.init();

  Intl.defaultLocale = "id_ID";

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Auth Provider from GetIt
        ChangeNotifierProvider(create: (_) => di.sl<AuthProvider>()),
        // Home Provider from GetIt
        ChangeNotifierProvider(create: (_) => di.sl<HomeProvider>()),
        // Profile Provider from GetIt
        ChangeNotifierProvider(create: (_) => di.sl<ProfileProvider>()),
        // Forgot Password Provider from GetIt
        ChangeNotifierProvider(create: (_) => di.sl<ForgotPasswordProvider>()),
        // Selfie Provider (global for biodata flow)
        ChangeNotifierProvider(create: (_) => SelfieProvider()),
        // Language Provider
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        // Screen Security Provider from GetIt
        ChangeNotifierProvider(create: (_) => di.sl<ScreenSecurityProvider>()),
      ],
      child: AppInitializer(),
    );
  }
}

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    // Initialize screen security after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeScreenSecurity();
    });
    _router = AppRouter.router();
  }

  Future<void> _initializeScreenSecurity() async {
    final authProvider = context.read<AuthProvider>();
    final screenSecurityProvider = context.read<ScreenSecurityProvider>();

    // Check if user is authenticated and has employeeId
    if (authProvider.isAuthenticated && authProvider.user?.employeeId != null) {
      await screenSecurityProvider.fetchAndApplySecuritySettings(
        type: 'employee',
        employeeWorkerId: authProvider.user!.employeeId!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp.router(
          title: 'MAHA Apps',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          routerConfig: _router,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            FlutterQuillLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('id', ''), // Indonesian
            Locale('en', ''), // English
          ],
          locale: languageProvider.currentLocale,
        );
      },
    );
  }
}
