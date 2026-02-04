import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/di/injection_container.dart' as di;
import 'core/router/app_router.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';
import 'features/authentication/presentation/providers/forgot_password_provider.dart';
import 'features/home/presentation/providers/home_provider.dart';
import 'features/profile/presentation/providers/profile_provider.dart';
import 'features/biodata/presentation/providers/selfie_provider.dart';
import 'core/providers/language_provider.dart';
import 'l10n/app_localizations.dart';
import 'shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize dependency injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter.router();
  }

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
      ],
      child: Consumer<LanguageProvider>(
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
            ],
            supportedLocales: const [
              Locale('id', ''), // Indonesian
              Locale('en', ''), // English
            ],
            locale: languageProvider.currentLocale,
          );
        },
      ),
    );
  }
}
