import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class SelfieProvider extends ChangeNotifier {
  CameraController? controller;
  XFile? selfieImage;
  XFile? selfieKtpImage;
  bool isCameraInitialized = false;
  bool isLoading = false;

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      // Use front camera for selfie, back camera for KTP usually, but let's default to front for selfie
      // logic can be improved to switch based on mode
      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
      
      controller = CameraController(
        frontCamera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller!.initialize();
      isCameraInitialized = true;
      notifyListeners();
    }
  }
  
  Future<void> initializeCameraKtp() async {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Use back camera for KTP
        final backCamera = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back,
          orElse: () => cameras.first,
        );

        controller = CameraController(
          backCamera,
          ResolutionPreset.high,
          enableAudio: false,
        );

        await controller!.initialize();
        isCameraInitialized = true;
        notifyListeners();
      }
  }

  Future<void> takePicture({bool isKtp = false}) async {
    if (controller != null && controller!.value.isInitialized) {
      isLoading = true;
      notifyListeners();
      try {
        final image = await controller!.takePicture();
        if (isKtp) {
          selfieKtpImage = image;
        } else {
          selfieImage = image;
        }
      } catch (e) {
        debugPrint('Error taking picture: $e');
      } finally {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void resetCamera() {
    selfieImage = null;
    selfieKtpImage = null;
    notifyListeners();
  }

  Future<void> disposeCamera() async {
    await controller?.dispose();
    controller = null;
    isCameraInitialized = false;
  }
  
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
