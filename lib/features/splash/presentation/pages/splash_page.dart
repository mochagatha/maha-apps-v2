// Splash Page - Preserving v1 UI/UX with Lottie animation
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/route_paths.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Wait for animation to play (approximately 3 seconds)
    await Future.delayed(const Duration(seconds: 7));

    if (!mounted) return;

    // Check authentication status
    final authProvider = context.read<AuthProvider>();
    await authProvider.checkAuth();

    if (!mounted) return;

    // Navigate based on auth status
    if (authProvider.isAuthenticated) {
      // Check status to match v1 logic
      // v1 source: employee?.data.status
      if (authProvider.user?.status == 1) {
        context.go(RoutePaths.welcomeBiodata);
      } else {
        context.go(RoutePaths.home);
      }
    } else {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9), // Remove gray background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Lottie.asset(
            'assets/splash.json',
            repeat: true,
            fit: BoxFit.contain, // Ensure proper fitting without background
            delegates: LottieDelegates(
              values: [
                // Hide common background layers that might be causing the grey background
                ValueDelegate.opacity(['**', 'Solid', '**'], value: 0),
                ValueDelegate.opacity(['**', 'Background', '**'], value: 0),
                ValueDelegate.opacity(['**', 'BG', '**'], value: 0),
                ValueDelegate.opacity(['**', 'White Solid', '**'], value: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(
      bytes,
      filePicker: (files) {
        return files.firstWhereOrNull(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'),
        );
      },
    );
  }
}
