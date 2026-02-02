import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/config/env_config.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/theme/app_theme.dart';

/// Privacy Notice Page
///
/// Displays the Privacy Notice PDF document from remote URL
/// Matches v1 UI design with CustomAppBar
class PrivacyNoticePage extends StatelessWidget {
  const PrivacyNoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pemberitahuan Privasi'),
      body: SafeArea(
        child: PDF().cachedFromUrl(
          "${EnvConfig.baseUrlPublic}/assets/doc/privacy-policy.pdf",
          placeholder: (progress) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpinKitThreeBounce(color: AppColors.primary, size: 30.0),
                const SizedBox(height: 16),
                Text('$progress %', style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          errorWidget: (error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Gagal memuat dokumen',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
