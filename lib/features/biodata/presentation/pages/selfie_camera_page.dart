import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/selfie_provider.dart';

class SelfieCameraPage extends StatefulWidget {
  const SelfieCameraPage({super.key});

  @override
  State<SelfieCameraPage> createState() => _SelfieCameraPageState();
}

class _SelfieCameraPageState extends State<SelfieCameraPage> {
  SelfieProvider? _selfieProvider;

  /// Guards against re-pushing selfieResult on every rebuild while allCaptured==true.
  bool _hasNavigatedToResult = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_selfieProvider == null) {
      _selfieProvider = context.read<SelfieProvider>();
      _selfieProvider!.addListener(_onProviderChanged);
      // Sync guard with current state (e.g. hot-reload, recreation)
      _hasNavigatedToResult = _selfieProvider!.allCaptured;
      // Only initialize camera if it hasn't been set up yet
      if (!_selfieProvider!.isCameraInitialized) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _selfieProvider!.initializeCamera(
              cameraLensDirection: CameraLensDirection.front,
            );
          }
        });
      }
    }
  }

  /// Listener: navigate to result exactly once per capture cycle.
  void _onProviderChanged() {
    if (!mounted) return;
    final provider = _selfieProvider!;

    // Show capture warning (no face detected) as a SnackBar.
    if (provider.captureWarning != null) {
      final warning = provider.captureWarning!;
      provider.clearCaptureWarning();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(warning),
              backgroundColor: Colors.red.shade700,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }

    if (provider.allCaptured && !_hasNavigatedToResult) {
      _hasNavigatedToResult = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.pushNamed(AppRoutes.selfieResult.name);
      });
    }
    if (!provider.allCaptured) {
      _hasNavigatedToResult = false;
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    _selfieProvider?.removeListener(_onProviderChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(title: 'Foto Selfie'),
      body: Consumer<SelfieProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              // Step indicator
              _buildStepIndicator(provider),

              // Angle label
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  provider.currentAngle.label,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Camera preview + overlay
              Expanded(child: _buildCameraPreview(provider)),

              // Guide text
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: const Text(
                  'Arahkan wajah ke dalam bingkai lalu tekan Ambil Foto',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Capture button
              _buildCaptureBar(provider),
            ],
          );
        },
      ),
    );
  }

  /// Three-step dot indicator at the top.
  Widget _buildStepIndicator(SelfieProvider provider) {
    final angles = SelfieAngle.values;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(angles.length * 2 - 1, (i) {
          if (i.isOdd) {
            // Connector line
            return Expanded(
              child: Divider(
                color: i ~/ 2 < provider.currentAngleIndex
                    ? AppColors.primary
                    : Colors.grey.shade300,
                thickness: 2,
              ),
            );
          }
          final stepIndex = i ~/ 2;
          final isCompleted = provider.capturedPhotos.containsKey(angles[stepIndex].value);
          final isActive = stepIndex == provider.currentAngleIndex;

          return Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? Colors.green
                      : isActive
                      ? AppColors.primary
                      : Colors.grey.shade300,
                ),
                child: Icon(
                  isCompleted ? Icons.check : Icons.face,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _angleName(angles[stepIndex].value),
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? AppColors.primary : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          );
        }),
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

  /// Camera preview with oval guide frame.
  Widget _buildCameraPreview(SelfieProvider provider) {
    if (!provider.isCameraInitialized || provider.controller == null) {
      return const Center(
        child: SpinKitThreeBounce(color: AppColors.primary),
      );
    }

    final controller = provider.controller!;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Camera feed
        FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: controller.value.previewSize?.height ?? 1,
            height: controller.value.previewSize?.width ?? 1,
            child: CameraPreview(controller),
          ),
        ),

        // Guide oval frame
        const CustomPaint(painter: _FaceGuidePainter()),

        // Processing spinner
        if (provider.isCapturingPhoto || provider.isProcessingCapture)
          Container(
            color: Colors.black54,
            child: const Center(
              child: SpinKitThreeBounce(color: Colors.white),
            ),
          ),
      ],
    );
  }

  Widget _buildCaptureBar(SelfieProvider provider) {
    final busy = provider.isCapturingPhoto || provider.isProcessingCapture;

    // All photos captured: show navigation button instead of camera button
    if (provider.allCaptured) {
      return Container(
        color: Colors.black,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: ElevatedButton.icon(
          onPressed: () => context.pushNamed(AppRoutes.selfieResult.name),
          icon: const Icon(Icons.check_circle_outline),
          label: const Text(
            'Lihat Hasil Foto',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );
    }

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      child: ElevatedButton.icon(
        onPressed: busy ? null : () => provider.manualCapture(),
        icon: const Icon(Icons.camera_alt),
        label: const Text(
          'Ambil Foto',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

/// Draws a rounded oval guide frame.
class _FaceGuidePainter extends CustomPainter {
  const _FaceGuidePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final ovalW = size.width * 0.62;
    final ovalH = size.height * 0.70;
    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: ovalW,
      height: ovalH,
    );

    // Dim background outside oval
    final backgroundPaint = Paint()..color = Colors.black54;
    final ovalPath = Path()..addOval(ovalRect);
    final fullRect = Path()..addRect(Offset.zero & size);
    final outside = Path.combine(PathOperation.difference, fullRect, ovalPath);
    canvas.drawPath(outside, backgroundPaint);

    // Oval border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white54;
    canvas.drawOval(ovalRect, borderPaint);
  }

  @override
  bool shouldRepaint(_FaceGuidePainter old) => false;
}
