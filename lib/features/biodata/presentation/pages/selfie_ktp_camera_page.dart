import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../providers/selfie_provider.dart';

class SelfieCameraKtpPage extends StatefulWidget {
  const SelfieCameraKtpPage({super.key});

  @override
  State<SelfieCameraKtpPage> createState() => _SelfieCameraKtpPageState();
}

class _SelfieCameraKtpPageState extends State<SelfieCameraKtpPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Initialize back camera or front with KTP mode?
      // v1 code used generic camera initialization, usually defaults to front or last used.
      // But typically selfie with ktp is also selfie camera.
      // We'll reuse initializeCamera from provider which defaults to front.
      // If back camera is preferred, we'd use initializeCameraKtp.
      // "Lengkapi proses ini dengan mengambil foto posisi selfie dengan memegang KTP." implies Selfie camera.
      context.read<SelfieProvider>().initializeCamera();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<SelfieProvider>(
        builder: (context, provider, child) {
          if (!provider.isCameraInitialized || provider.controller == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Stack(
            fit: StackFit.expand,
            children: [
              CameraPreview(provider.controller!),
              // Overlay KTP
              // Needs a shape that shows where to hold KTP usually
              // For now, simpler overlay or reuse simple one
              // We'll add a secondary box for KTP area hint if needed
              Container(
                decoration: ShapeDecoration(
                  shape: _ScannerOverlayShapeKtp(
                    borderColor: Colors.white,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 5,
                    cutOutSize: 300,
                  ),
                ),
              ),

              const Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Text(
                  "Pegang KTP Anda di bawah dagu",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              Positioned(
                bottom: 30,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 30),
                      onPressed: () => context.pop(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await provider.takePicture(isKtp: true);
                        if (context.mounted && provider.selfieKtpImage != null) {
                          context.pushNamed(RouteNames.selfieResultKtp);
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          color: Colors.transparent,
                        ),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Custom painter for overlay KTP (Wajah + Card logic ideally)
class _ScannerOverlayShapeKtp extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;
  final double borderRadius;
  final double borderLength;
  final double cutOutSize;

  const _ScannerOverlayShapeKtp({
    this.borderColor = Colors.white,
    this.borderWidth = 10.0,
    this.overlayColor = const Color.fromRGBO(0, 0, 0, 0.5),
    this.borderRadius = 10.0,
    this.borderLength = 20.0,
    this.cutOutSize = 250.0,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // Return path that includes Face and Card area
    // Simplified: Just one big rect for now, effectively same as selfie
    return Path()..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: rect.center, width: cutOutSize, height: cutOutSize * 1.5),
        Radius.circular(borderRadius),
      ),
    );
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path()..addRect(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // Reuse similar painting logic
    final width = rect.width;
    final height = rect.height;
    final cutOutWidth = cutOutSize;
    final cutOutHeight = cutOutSize * 1.5;

    final backgroundPaint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    final cutOutRect = Rect.fromCenter(
      center: rect.center,
      width: cutOutWidth,
      height: cutOutHeight,
    );

    final backgroundPath = Path()
      ..addRect(rect)
      ..addRRect(RRect.fromRectAndRadius(cutOutRect, Radius.circular(borderRadius)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(backgroundPath, backgroundPaint);
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShapeKtp(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
