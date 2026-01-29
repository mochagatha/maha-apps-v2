import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/admin_face_provider.dart';
import '../providers/auth_provider.dart';

/// Admin face camera page with face detection and auto-upload
class AdminFaceCameraPage extends StatelessWidget {
  const AdminFaceCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AdminFaceCameraView();
  }
}

class _AdminFaceCameraView extends StatefulWidget {
  const _AdminFaceCameraView();

  @override
  State<_AdminFaceCameraView> createState() => _AdminFaceCameraViewState();
}

class _AdminFaceCameraViewState extends State<_AdminFaceCameraView> {
  late Stream<DateTime> _timeStream;

  @override
  void initState() {
    super.initState();
    _timeStream = Stream<DateTime>.periodic(
      const Duration(seconds: 1),
      (x) => DateTime.now(),
    ).asBroadcastStream();
  }

  void _handleUploadStatus(BuildContext context, AdminFaceProvider provider) {
    if (provider.uploadStatus == UploadStatus.success) {
      // Navigate to admin home on success
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(RoutePaths.adminHome);
      });
    } else if (provider.uploadStatus == UploadStatus.error) {
      // Show error dialog
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showErrorDialog(context, provider.uploadErrorMessage ?? 'Upload failed', provider);
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message, AdminFaceProvider provider) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Verifikasi Gagal'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.resetVerification();
            },
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AdminFaceProvider, AuthProvider>(
      builder: (context, provider, authProvider, child) {
        // Auto-upload when image is saved
        if (provider.isImageSaved &&
            provider.imagePath != null &&
            provider.uploadStatus == UploadStatus.idle) {
          final user = authProvider.user;
          if (user?.employeeId != null) {
            // Use a microtask to avoid setState during build
            Future.microtask(() => provider.uploadPhoto(user!.employeeId!));
          } else {
            Future.microtask(() {
              _showErrorDialog(context, "Data admin tidak ditemukan.", provider);
            });
          }
        }

        // Listen to upload status changes
        if (provider.uploadStatus != UploadStatus.idle &&
            provider.uploadStatus != UploadStatus.uploading) {
          _handleUploadStatus(context, provider);
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Verifikasi Wajah',
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
          ),
          body: Stack(
            children: [
              !provider.isCameraInitialized
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : Column(
                      children: [
                        // Camera preview with face detection overlay
                        Stack(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: provider.cameraController != null
                                  ? CameraPreview(
                                      provider.cameraController!,
                                      child: provider.customPaint,
                                    )
                                  : const Center(child: CircularProgressIndicator()),
                            ),

                            // Info overlay at bottom of camera
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(16.0),
                                color: Colors.black.withOpacity(0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Date and time
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat(
                                            'EEEE, dd/MM/yyyy',
                                            'id_ID',
                                          ).format(DateTime.now()),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(
                                          child: StreamBuilder<DateTime>(
                                            stream: _timeStream,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                final time = snapshot.data!;
                                                final formattedTime =
                                                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} WIB';
                                                return Text(
                                                  formattedTime,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              } else {
                                                return const Text(
                                                  'Loading...',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // Blink instruction
                                    Row(
                                      children: [
                                        const Icon(Icons.circle, color: Colors.red, size: 10),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            'Kedipkan mata untuk menangkap gambar wajah',
                                            style: const TextStyle(
                                              color: Color(0xffE91E21),
                                              fontSize: 12,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

              // Loading overlay when uploading
              if (provider.uploadStatus == UploadStatus.uploading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(color: Colors.white),
                        const SizedBox(height: 16),
                        Text(
                          'Mengirim data...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
