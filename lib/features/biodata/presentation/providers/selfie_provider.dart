import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/ml/face_embedding_service.dart';
import '../../domain/entities/user_photo.dart';
import '../../domain/usecases/submit_employee_document.dart';
import '../../domain/usecases/submit_user_photo.dart';
import '../../domain/usecases/confirm_employee_data.dart';

/// Angle constants — order matters (captures in this order).
enum SelfieAngle {
  front('front', 'Hadapkan Wajah ke Depan'),
  right('right', 'Hadapkan Wajah ke Kanan'),
  left('left', 'Hadapkan Wajah ke Kiri');

  const SelfieAngle(this.value, this.label);
  final String value;
  final String label;
}

class SelfieProvider extends ChangeNotifier {
  final SubmitEmployeeDocument submitEmployeeDocumentUseCase;
  final SubmitUserPhoto submitUserPhotoUseCase;
  final ConfirmEmployeeData confirmEmployeeDataUseCase;
  final FaceEmbeddingService faceEmbeddingService;
  final SharedPreferences sharedPreferences;

  SelfieProvider({
    required this.submitEmployeeDocumentUseCase,
    required this.submitUserPhotoUseCase,
    required this.confirmEmployeeDataUseCase,
    required this.faceEmbeddingService,
    required this.sharedPreferences,
  });

  // Camera state
  CameraController? controller;
  bool isCameraInitialized = false;

  // Legacy KTP selfie (kept for backward compat with KTP flow)
  XFile? selfieImage;
  XFile? selfieKtpImage;
  bool isLoading = false;
  bool isUploading = false;
  String? uploadErrorMessage;

  // 3-angle selfie state
  int currentAngleIndex = 0; // 0=front 1=right 2=left
  final Map<String, XFile> capturedPhotos = {};
  final Map<String, List<double>> capturedEmbeddings = {};
  bool allCaptured = false;

  // Per-angle processing state
  bool isProcessingCapture = false;
  bool isCapturingPhoto = false;

  // Warning shown when capture attempted without a detected face
  String? captureWarning;

  void clearCaptureWarning() {
    captureWarning = null;
  }

  // Upload state
  bool isSubmitting = false;
  final Map<String, String?> submitErrors = {};
  bool get submitSuccess =>
      submitErrors.isNotEmpty &&
      submitErrors.values.every((e) => e == null) &&
      submitErrors.length == SelfieAngle.values.length;

  SelfieAngle get currentAngle => SelfieAngle.values[currentAngleIndex];

  // Camera init / dispose

  Future<void> initializeCamera({
    CameraLensDirection cameraLensDirection = CameraLensDirection.front,
  }) async {
    isCameraInitialized = false;
    notifyListeners();
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == cameraLensDirection,
        orElse: () => cameras.first,
      );
      if (controller != null) await controller!.dispose();

      controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );
      await controller!.initialize();

      await faceEmbeddingService.initialize();

      isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('[SelfieProvider] initializeCamera error: $e');
    }
  }

  Future<void> disposeCamera() async {
    if (controller != null) {
      await controller!.dispose();
      controller = null;
      isCameraInitialized = false;
    }
  }

  // Capture

  /// Manual capture — takes a photo and detects faces in the captured image.
  Future<void> manualCapture() async {
    if (isCapturingPhoto || isProcessingCapture) return;
    captureWarning = null;
    await _captureCurrentAngle();
  }

  Future<void> _captureCurrentAngle() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (isCapturingPhoto || isProcessingCapture) return;

    isCapturingPhoto = true;
    notifyListeners();

    XFile? photo;
    try {
      photo = await controller!.takePicture();
    } catch (e) {
      debugPrint('[SelfieProvider] takePicture error: $e');
      isCapturingPhoto = false;
      notifyListeners();
      return;
    }
    isCapturingPhoto = false;
    isProcessingCapture = true;
    notifyListeners();

    final angle = currentAngle;
    bool didCaptureFace = false;
    try {
      final result = await faceEmbeddingService.processImage(photo);

      if (result != null) {
        capturedPhotos[angle.value] = result.croppedFace;
        capturedEmbeddings[angle.value] = result.embedding;
        if (angle == SelfieAngle.front) selfieImage = result.croppedFace;
        captureWarning = null;
        didCaptureFace = true;
      } else {
        // No face found in the captured photo — warn and do NOT advance.
        captureWarning = 'Tidak ada wajah terdeteksi. Silakan coba lagi.';
        debugPrint('[SelfieProvider] No face in captured photo for ${angle.value}');
      }
    } catch (e) {
      debugPrint('[SelfieProvider] processImage error: $e');
      captureWarning = 'Tidak ada wajah terdeteksi. Silakan coba lagi.';
    } finally {
      if (didCaptureFace) {
        // Find the next angle that has NOT been captured yet (supports partial retake).
        final nextIndex = _findNextUncapturedIndex();
        if (nextIndex != null) {
          currentAngleIndex = nextIndex;
        } else {
          allCaptured = true;
        }
      }
      isProcessingCapture = false;
      notifyListeners();
    }
  }

  /// Returns the index of the first [SelfieAngle] whose photo has not yet
  /// been captured, or `null` when all angles are covered.
  int? _findNextUncapturedIndex() {
    for (int i = 0; i < SelfieAngle.values.length; i++) {
      if (!capturedPhotos.containsKey(SelfieAngle.values[i].value)) return i;
    }
    return null;
  }

  // Retake

  Future<void> retakeAngle(SelfieAngle angle) async {
    capturedPhotos.remove(angle.value);
    capturedEmbeddings.remove(angle.value);
    allCaptured = false;
    currentAngleIndex = SelfieAngle.values.indexOf(angle);
    captureWarning = null;
    submitErrors.clear();
    notifyListeners();
    if (controller == null || !controller!.value.isInitialized) {
      await initializeCamera(cameraLensDirection: CameraLensDirection.front);
    }
  }

  /// Resets all captured data and restarts the camera stream from angle 0.
  Future<void> resetAll() async {
    capturedPhotos.clear();
    capturedEmbeddings.clear();
    allCaptured = false;
    currentAngleIndex = 0;
    captureWarning = null;
    submitErrors.clear();
    notifyListeners();
    if (controller == null || !controller!.value.isInitialized) {
      await initializeCamera(cameraLensDirection: CameraLensDirection.front);
    }
  }

  // Helper: read an int pref that may have been stored as String or int
  int? _getIntPref(String key) {
    try {
      final v = sharedPreferences.get(key);
      if (v is int) return v;
      if (v is String) return int.tryParse(v);
    } catch (_) {}
    return null;
  }

  // Submit

  Future<bool> submitAllUserPhotos() async {
    final userId = _getIntPref('user_id') ?? _getIntPref('employee_id');
    if (userId == null) {
      for (final a in SelfieAngle.values) {
        submitErrors[a.value] = 'ID pengguna tidak ditemukan';
      }
      notifyListeners();
      return false;
    }

    isSubmitting = true;
    submitErrors.clear();
    notifyListeners();

    for (final angle in SelfieAngle.values) {
      final photo = capturedPhotos[angle.value];
      final embedding = capturedEmbeddings[angle.value];
      if (photo == null || embedding == null) {
        submitErrors[angle.value] = 'Foto ${angle.label} belum diambil';
        continue;
      }

      final userPhoto = UserPhoto(
        userId: userId,
        userType: 'employee',
        faceAngle: angle.value,
        photoPath: photo.path,
        photoEmbedding: embedding,
      );

      final result = await submitUserPhotoUseCase(
        SubmitUserPhotoParams(userPhoto: userPhoto),
      );

      result.fold(
        (failure) => submitErrors[angle.value] = failure.message,
        (_) => submitErrors[angle.value] = null,
      );
    }

    isSubmitting = false;
    notifyListeners();
    return submitErrors.values.every((e) => e == null);
  }

  // Legacy KTP selfie methods (kept for selfie_ktp_camera_page.dart)

  Future<void> takePicture({bool isKtp = false}) async {
    if (controller == null || !controller!.value.isInitialized) return;
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
      debugPrint('[SelfieProvider] takePicture (legacy) error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> uploadSelfieWithKtp() async {
    if (selfieKtpImage == null) return 'Foto selfie dengan KTP belum diambil';
    final employeeId = _getIntPref('employee_id');
    if (employeeId == null) return 'ID karyawan tidak ditemukan';

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
      (_) async {
        // Confirm employee data after successful KTP upload
        final employeeId = _getIntPref('employee_id');
        if (employeeId != null) {
          final confirmDate = DateTime.now().toIso8601String().substring(0, 10);
          await confirmEmployeeDataUseCase(
            ConfirmEmployeeDataParams(
              employeeId: employeeId,
              confirmDate: confirmDate,
            ),
          );
        }
        notifyListeners();
        return null;
      },
    );
  }

  void resetCamera() => notifyListeners();

  @override
  void dispose() {
    controller?.dispose();
    controller = null;
    faceEmbeddingService.dispose();
    super.dispose();
  }
}
