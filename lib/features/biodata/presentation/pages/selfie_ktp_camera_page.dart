import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../core/router/route_names.dart';
import '../providers/selfie_provider.dart';

class SelfieCameraKtpPage extends StatefulWidget {
  const SelfieCameraKtpPage({super.key});

  @override
  State<SelfieCameraKtpPage> createState() => _SelfieCameraKtpPageState();
}

class _SelfieCameraKtpPageState extends State<SelfieCameraKtpPage> {
  SelfieProvider? _selfieProvider;

  // Guides from V1 KTP
  final List<String> guideSelfie = [
    'Jelas & Berada di bingkai',
    'Foto Tampak Buram',
    'Wajah Tampak Gelap',
    'Wajah Terpotong',
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
      // KTP usually uses front camera in this app context based on "Selfie dengan KTP"
      // but lets verify vs v1.
      // v1 `regis_face_recognition_ktp_screen.dart` uses `_cameraLensDirection = CameraLensDirection.front;` initially.
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
            await provider.takePicture(isKtp: true);
            if (context.mounted && provider.selfieKtpImage != null) {
              // Dispose camera before navigating to prevent camera staying active
              await provider.disposeCamera();
              if (context.mounted) {
                context.pushNamed(RouteNames.selfieResultKtp);
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
