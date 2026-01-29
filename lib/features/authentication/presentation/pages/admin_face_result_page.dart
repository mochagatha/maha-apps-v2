import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/admin_face_provider.dart';
import '../providers/auth_provider.dart';

/// Admin face verification result page
class AdminFaceResultPage extends StatefulWidget {
  final String imagePath;

  const AdminFaceResultPage({super.key, required this.imagePath});

  @override
  State<AdminFaceResultPage> createState() => _AdminFaceResultPageState();
}

class _AdminFaceResultPageState extends State<AdminFaceResultPage> {
  AdminFaceProvider? _provider;

  @override
  void initState() {
    super.initState();
    // Set image path and listen to upload status changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _provider = context.read<AdminFaceProvider>();
      _provider?.setImagePath(widget.imagePath);
      _provider?.addListener(_onUploadStatusChanged);
    });
  }

  @override
  void dispose() {
    _provider?.removeListener(_onUploadStatusChanged);
    super.dispose();
  }

  void _onUploadStatusChanged() {
    if (!mounted) return;
    
    final provider = context.read<AdminFaceProvider>();

    if (provider.uploadStatus == UploadStatus.success) {
      // Navigate to admin home on success
      if (mounted) {
        context.go(RoutePaths.adminHome);
      }
    } else if (provider.uploadStatus == UploadStatus.error) {
      // Show error dialog
      if (mounted) {
        _showErrorDialog(provider.uploadErrorMessage ?? 'Upload failed');
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Upload Error'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK')),
        ],
      ),
    );
  }

  Future<void> _handleUpload() async {
    final authProvider = context.read<AuthProvider>();
    final faceProvider = context.read<AdminFaceProvider>();

    // Get admin ID from current user
    final user = authProvider.user;
    if (user?.employeeId == null) {
      _showErrorDialog('Admin ID not found');
      return;
    }

    // Upload photo
    await faceProvider.uploadPhoto(user!.employeeId!);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminFaceProvider>(
      builder: (context, provider, child) {
        final isUploading = provider.uploadStatus == UploadStatus.uploading;

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
                        child: Image.file(File(widget.imagePath), fit: BoxFit.contain),
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
                    onPressed: isUploading ? null : _handleUpload,
                    child: isUploading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : const Text('Lanjutkan'),
                  ),

                  const SizedBox(height: 12),

                  OutlinedButton(
                    onPressed: isUploading
                        ? null
                        : () {
                            context.go(RoutePaths.adminFaceCamera);
                          },
                    child: const Text('Ambil Ulang Foto'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
