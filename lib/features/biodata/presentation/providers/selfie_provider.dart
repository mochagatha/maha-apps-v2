import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/submit_employee_document.dart';

class SelfieProvider extends ChangeNotifier {
  final SubmitEmployeeDocument submitEmployeeDocumentUseCase;
  final SharedPreferences sharedPreferences;

  SelfieProvider({
    required this.submitEmployeeDocumentUseCase,
    required this.sharedPreferences,
  });

  CameraController? controller;
  XFile? selfieImage;
  XFile? selfieKtpImage;
  bool isCameraInitialized = false;
  bool isLoading = false;
  bool isUploading = false;
  String? uploadErrorMessage;

  Future<void> initializeCamera({
    CameraLensDirection cameraLensDirection = CameraLensDirection.front,
  }) async {
    isCameraInitialized = false;
    // notifyListeners(); // Avoid rebuilding too early if not needed, or helps show loader

    try {
      final cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        final camera = cameras.firstWhere(
          (camera) => camera.lensDirection == cameraLensDirection,
          orElse: () => cameras.first,
        );

        // Dispose old controller if exists
        if (controller != null) {
          await controller!.dispose();
        }

        controller = CameraController(camera, ResolutionPreset.high, enableAudio: false);

        await controller!.initialize();
        isCameraInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error initializing camera: $e");
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
    // selfieImage = null; // Do not clear images on reset, only maybe when starting fresh flow
    // selfieKtpImage = null;
    notifyListeners();
  }

  // Call this when leaving the flow
  Future<void> disposeCamera() async {
    if (controller != null) {
      await controller!.dispose();
      controller = null;
      isCameraInitialized = false;
      // Don't call notifyListeners here as widget might be disposed
    }
  }

  /// Upload selfie with KTP photo to POST /employee/employee-document
  /// Returns null on success, or an error message string on failure.
  Future<String?> uploadSelfieWithKtp() async {
    if (selfieKtpImage == null) {
      return 'Foto selfie dengan KTP belum diambil';
    }

    final employeeId = sharedPreferences.getInt('employee_id');
    if (employeeId == null) {
      return 'ID karyawan tidak ditemukan';
    }

    isUploading = true;
    uploadErrorMessage = null;
    notifyListeners();

    final result = await submitEmployeeDocumentUseCase(
      SubmitEmployeeDocumentParams(
        employeeId: employeeId,
        photoWithKtpPath: selfieKtpImage!.path,
      ),
    );

    isUploading = false;

    return result.fold(
      (failure) {
        uploadErrorMessage = failure.message;
        notifyListeners();
        return failure.message;
      },
      (_) {
        notifyListeners();
        return null;
      },
    );
  }

  @override
  void dispose() {
    // Synchronously dispose controller
    controller?.dispose();
    controller = null;
    super.dispose();
  }
}
