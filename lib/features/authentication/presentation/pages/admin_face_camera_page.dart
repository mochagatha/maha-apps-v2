import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/admin_face_provider.dart';

/// Admin face camera page with face detection
class AdminFaceCameraPage extends StatelessWidget {
  const AdminFaceCameraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AdminFaceProvider(),
      child: const _AdminFaceCameraView(),
    );
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

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminFaceProvider>(
      builder: (context, provider, child) {
        // Navigate to result page when image is captured
        if (provider.isImageSaved && provider.imagePath != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(RoutePaths.adminFaceResult, extra: provider.imagePath);
          });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Verifikasi Wajah'),
            leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
          ),
          body: !provider.isCameraInitialized
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
                                              style: TextStyle(color: Colors.white, fontSize: 14),
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

                    // Instructions below camera
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.face, size: 48, color: AppColors.primary),
                            const SizedBox(height: 16),
                            const Text(
                              'Posisikan wajah Anda di dalam kotak',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Kedipkan mata untuk mengambil foto',
                              style: TextStyle(fontSize: 14, color: AppColors.neutral6),
                              textAlign: TextAlign.center,
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
