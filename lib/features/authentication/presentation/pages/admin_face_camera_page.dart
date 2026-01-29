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
import '../../../../core/utils/localization_extension.dart';

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
        title: Text(context.l10n.verificationFailed),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              provider.resetVerification();
            },
            child: Text(context.l10n.tryAgain),
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
              _showErrorDialog(context, context.l10n.adminDataNotFound, provider);
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
            title: context.l10n.faceVerification,
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
          ),
          body: Stack(
            children: [
              !provider.isCameraInitialized
                  ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
                  : Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
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
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Date and time
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(child: SizedBox()),
                                    Text(
                                      DateFormat(
                                        'EEEE, dd/MM/yyyy',
                                        Localizations.localeOf(context).toString(),
                                      ).format(DateTime.now()),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,

                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    StreamBuilder<DateTime>(
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
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        } else {
                                          return Text(
                                            context.l10n.loading,
                                            style: TextStyle(color: Colors.white, fontSize: 12),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Location
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(width: MediaQuery.sizeOf(context).width * .2),
                                    Expanded(
                                      child: Text(
                                        provider.locationName ?? 'Loading...',
                                        style: const TextStyle(color: Colors.white, fontSize: 12),
                                        maxLines: 3,
                                        textAlign: TextAlign.end,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),

                                // Blink instruction
                                Container(
                                  padding: const EdgeInsets.all(16.0),
                                  color: Colors.black.withOpacity(0.5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.circle, color: Colors.red, size: 10),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          context.l10n.blinkInstruction,
                                          style: const TextStyle(
                                            color: Color(0xffE91E21),
                                            fontSize: 12,
                                          ),
                                          maxLines: 2,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                          context.l10n.sendingData,
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
