import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../core/utils/localization_extension.dart';

/// Admin face verification instruction page
class AdminFaceVerificationPage extends StatelessWidget {
  const AdminFaceVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.adminFaceVerificationTitle,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(RoutePaths.login),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),

              // Icon
              const Icon(Icons.face, size: 120, color: AppColors.primary),

              const SizedBox(height: 40),

              // Title
              Text(
                context.l10n.faceVerification,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Instructions
              Text(
                context.l10n.faceVerificationDesc,
                style: TextStyle(fontSize: 16, color: AppColors.neutral6),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              // Instructions list
              _buildInstructionItem(Icons.camera_front, context.l10n.faceVisibleInstruction),
              const SizedBox(height: 16),
              _buildInstructionItem(Icons.light_mode, context.l10n.sufficientLightingInstruction),
              const SizedBox(height: 16),
              _buildInstructionItem(Icons.remove_red_eye, context.l10n.blinkToCaptureInstruction),

              const Spacer(),

              // Start button
              ElevatedButton(
                onPressed: () {
                  context.push(RoutePaths.adminFaceCamera);
                },
                child: Text(context.l10n.startVerification),
              ),

              const SizedBox(height: 16),

              // Cancel button
              TextButton(
                onPressed: () {
                  context.go(RoutePaths.login);
                },
                child: Text(context.l10n.cancel),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInstructionItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(width: 16),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
