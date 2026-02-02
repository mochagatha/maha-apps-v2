import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/config/env_config.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/theme/app_theme.dart';

/// Terms and Conditions Page
///
/// Displays the Terms and Conditions PDF document from remote URL
/// Matches v1 UI design with CustomAppBar
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Syarat dan Ketentuan'),
      body: SafeArea(
        child: PDF().cachedFromUrl(
          "${EnvConfig.baseUrlPublic}/assets/doc/s&k.pdf",
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
