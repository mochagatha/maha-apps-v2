import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';

/// Admin face verification result page
class AdminFaceResultPage extends StatelessWidget {
  final String imagePath;

  const AdminFaceResultPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Foto'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                'Foto Wajah Berhasil Diambil',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Text(
                'Periksa foto Anda sebelum melanjutkan',
                style: TextStyle(fontSize: 14, color: AppColors.neutral6),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Captured image preview
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(File(imagePath), fit: BoxFit.contain),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Info text
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.primary, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Foto akan dikirim ke server dan dicatat ke dalam log aktivitas',
                        style: TextStyle(fontSize: 12, color: AppColors.neutral7),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Action buttons
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement upload to backend
                  // For now, just navigate to admin home
                  context.go(RoutePaths.adminHome);
                },
                child: const Text('Lanjutkan'),
              ),

              const SizedBox(height: 12),

              OutlinedButton(
                onPressed: () {
                  context.go(RoutePaths.adminFaceCamera);
                },
                child: const Text('Ambil Ulang Foto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
