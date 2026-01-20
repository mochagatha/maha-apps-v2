// Splash Page - Preserving v1 UI/UX with Lottie animation
import 'package:flutter/material.dart';
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
      context.go(RoutePaths.home);
    } else {
      context.go(RoutePaths.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Remove gray background
      body: Center(
        child: Lottie.asset(
          'assets/splash_modified.json',
          repeat: true,
          fit: BoxFit.contain, // Ensure proper fitting without background
        ),
      ),
    );
  }
}
