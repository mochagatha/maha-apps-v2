import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../core/router/app_routes.dart';
import '../providers/selfie_provider.dart';

class SelfieCameraPage extends StatefulWidget {
  const SelfieCameraPage({super.key});

  @override
  State<SelfieCameraPage> createState() => _SelfieCameraPageState();
}

class _SelfieCameraPageState extends State<SelfieCameraPage> {
  SelfieProvider? _selfieProvider;

  // Guides from V1
  final List<String> guideSelfie = [
    'Jelas & Berada di bingkai',
    'Foto Tampak Buram',
    'Wajah Tampak Gelap',
    'Wajah Terpotong',
  ];

  final List<String> guideSelfie2 = [
    'Foto Selfie kamu dengan menggunakan pakaian sopan',
    'Foto Selfie jelas (tidak buram)',
    'Foto Selfie dengan cahaya yang cukup (tidak gelap)',
    'Foto Selfie tidak terpotong',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Save provider reference safely
    _selfieProvider ??= context.read<SelfieProvider>();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SelfieProvider>().initializeCamera(
        cameraLensDirection: CameraLensDirection.front,
      );
    });
  }

  @override
  void deactivate() {
    // Stop camera when widget is being removed from tree
    _selfieProvider?.disposeCamera();
    super.deactivate();
  }

  @override
  void dispose() {
    // Dispose camera when leaving this page
    _selfieProvider?.disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double previewAspectRatio = 1.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Foto Selfie'),
      body: Consumer<SelfieProvider>(
        builder: (context, provider, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Camera Preview Section
              AspectRatio(
                aspectRatio: 1 / previewAspectRatio,
                child: ClipRect(
                  child: provider.isCameraInitialized && provider.controller != null
                      ? Transform.scale(
                          scale: provider.controller!.value.aspectRatio / previewAspectRatio,
                          child: Center(child: CameraPreview(provider.controller!)),
                        )
                      : const Center(child: SpinKitThreeBounce(color: AppColors.primary)),
                ),
              ),

              // Guide Section
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Panduan Foto Selfie :',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (int i = 0; i < 4; i++)
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width * 0.22,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Image.asset(
                                            'assets/images/icon/selfie${i + 1}.png',
                                            fit: BoxFit.contain,
                                          ),
                                          Text(
                                            '${guideSelfie[i]}\n',
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              ...guideSelfie2.map(
                                (e) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('•'),
                                    const SizedBox(width: 8),
                                    Expanded(child: Text(e, style: const TextStyle(fontSize: 12))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () async {
            final provider = context.read<SelfieProvider>();
            await provider.takePicture();
            if (context.mounted && provider.selfieImage != null) {
              // Dispose camera before navigating to prevent camera staying active
              // await provider.disposeCamera();
              if (context.mounted) {
                context.pushNamed(AppRoutes.selfieResult.name);
              }
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text(
            'Ambil Foto Selfie',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
