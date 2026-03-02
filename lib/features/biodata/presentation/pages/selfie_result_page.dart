import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../core/router/app_routes.dart';
import '../../domain/services/biodata_step_manager.dart';
import '../providers/selfie_provider.dart';

class SelfieResultPage extends StatelessWidget {
  const SelfieResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Hasil Foto Selfie'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<SelfieProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Periksa ketiga foto selfie Anda sebelum dikirim.',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 16),

                // Three photo thumbnails
                Row(
                  children: SelfieAngle.values.map((angle) {
                    return Expanded(
                      child: _AngleThumbnail(
                        angle: angle,
                        provider: provider,
                        onRetake: () async {
                          await provider.retakeAngle(angle);
                          if (context.mounted) context.pop();
                        },
                      ),
                    );
                  }).toList(),
                ),

                // Per-angle errors (if any previous submit attempt)
                if (provider.submitErrors.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ...SelfieAngle.values
                      .where((a) => provider.submitErrors[a.value] != null)
                      .map((a) => Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.red, size: 16),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    '${_angleName(a.value)}: ${provider.submitErrors[a.value]}',
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ],

                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isSubmitting
                        ? null
                        : () async {
                            final success =
                                await provider.submitAllUserPhotos();
                            if (!context.mounted) return;
                            if (success) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Foto berhasil dikirim!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              BiodataStepManager.setNextStep(
                                  AppRoutes.selfieKtpForm.path);
                              context.pushNamed(AppRoutes.selfieKtpForm.name);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Gagal mengirim beberapa foto. Periksa detail di atas.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: provider.isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : const Text(
                            'Konfirmasi & Kirim',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),

                const SizedBox(height: 12),

                // Retake all button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: provider.isSubmitting ? null : () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      'Ulangi Semua Foto',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _angleName(String value) {
    switch (value) {
      case 'front':
        return 'Depan';
      case 'right':
        return 'Kanan';
      case 'left':
        return 'Kiri';
      default:
        return value;
    }
  }
}

class _AngleThumbnail extends StatelessWidget {
  final SelfieAngle angle;
  final SelfieProvider provider;
  final VoidCallback onRetake;

  const _AngleThumbnail({
    required this.angle,
    required this.provider,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    final photo = provider.capturedPhotos[angle.value];
    final hasError = provider.submitErrors[angle.value] != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        children: [
          // Photo box
          Container(
            height: 140,
            decoration: BoxDecoration(
              border: Border.all(
                color: hasError ? Colors.red : Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade100,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: photo != null
                  ? Image.file(
                      File(photo.path),
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : const Center(
                      child: Icon(Icons.image_not_supported,
                          color: Colors.grey, size: 36)),
            ),
          ),

          const SizedBox(height: 6),

          // Angle label
          Text(
            _angleName(angle.value),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 4),

          // Retake button
          GestureDetector(
            onTap: onRetake,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Ulangi',
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 11,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _angleName(String value) {
    switch (value) {
      case 'front':
        return 'Depan';
      case 'right':
        return 'Kanan';
      case 'left':
        return 'Kiri';
      default:
        return value;
    }
  }
}
