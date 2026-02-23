import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/router/app_routes.dart';
import '../providers/permission_provider.dart';
import '../widgets/permission_denied_dialog.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({super.key});

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-check permissions when returning to the app (e.g., from Settings)
      context.read<PermissionProvider>().checkPermissions().then((_) {
        _navigateIfGranted();
      });
    }
  }

  void _navigateIfGranted() {
    final provider = context.read<PermissionProvider>();
    if (provider.state == PermissionState.granted) {
      context.go(AppRoutes.splash.path);
    }
  }

  void _showPermissionDeniedDialog() {
    final provider = context.read<PermissionProvider>();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PermissionDeniedDialog(
        deniedPermissions: provider.deniedPermissions,
        onOpenSettings: () async {
          await provider.openSettings();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Consumer<PermissionProvider>(
            builder: (context, provider, child) {
              if (provider.state == PermissionState.granted) {
                // Should navigate away, but shows success just in case
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.go(AppRoutes.splash.path);
                });
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  // Lottie Animation or Image
                  Lottie.asset(
                    'assets/splash.json', // Reuse splash or use specific permission asset
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Izin Diperlukan',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aplikasi ini memerlukan akses Kamera dan Lokasi untuk berfungsi dengan baik. Mohon berikan izin untuk melanjutkan.',
                    style: GoogleFonts.outfit(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(233, 30, 33, 1),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: () async {
                        await provider.requestPermissions();
                        if (context.mounted) {
                          if (provider.state == PermissionState.granted) {
                            context.go(AppRoutes.splash.path);
                          } else if (provider.state == PermissionState.permanentlyDenied) {
                            // Show dialog with details
                            _showPermissionDeniedDialog();
                          }
                        }
                      },
                      child: Text(
                        'Izinkan Akses',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      provider.openSettings();
                    },
                    child: Text(
                      'Buka Pengaturan',
                      style: GoogleFonts.outfit(color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
