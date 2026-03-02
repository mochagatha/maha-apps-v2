import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/ml/face_embedding_service.dart';
import '../../domain/entities/user_photo.dart';
import '../../domain/usecases/submit_employee_document.dart';
import '../../domain/usecases/submit_user_photo.dart';

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
  final FaceEmbeddingService faceEmbeddingService;
  final SharedPreferences sharedPreferences;

  SelfieProvider({
    required this.submitEmployeeDocumentUseCase,
    required this.submitUserPhotoUseCase,
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

  // Real-time face detection state
  bool faceDetected = false;
  List<Face> detectedFaces = [];
  Size? imageSize;

  // Countdown state
  int? countdownValue;
  Timer? _countdownTimer;

  // Per-angle processing state
  bool isProcessingCapture = false;
  bool isCapturingPhoto = false;

  // Upload state
  bool isSubmitting = false;
  final Map<String, String?> submitErrors = {};
  bool get submitSuccess =>
      submitErrors.isNotEmpty &&
      submitErrors.values.every((e) => e == null) &&
      submitErrors.length == SelfieAngle.values.length;

  // Face detector (stream-only, fast mode)
  FaceDetector? _streamFaceDetector;
  bool _isDetecting = false;

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
        imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
      );
      await controller!.initialize();

      await faceEmbeddingService.initialize();
      _initStreamDetector();
      await _startImageStream();

      isCameraInitialized = true;
      notifyListeners();
    } catch (e) {
      debugPrint('[SelfieProvider] initializeCamera error: $e');
    }
  }

  void _initStreamDetector() {
    _streamFaceDetector?.close();
    _streamFaceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.fast,
        enableLandmarks: false,
        enableClassification: false,
        minFaceSize: 0.15,
      ),
    );
  }

  Future<void> _startImageStream() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (controller!.value.isStreamingImages) return;
    await controller!.startImageStream(_processCameraFrame);
  }

  Future<void> _stopImageStream() async {
    if (controller == null) return;
    if (controller!.value.isStreamingImages) {
      await controller!.stopImageStream();
    }
  }

  Future<void> disposeCamera() async {
    _cancelCountdown();
    await _stopImageStream();
    _streamFaceDetector?.close();
    _streamFaceDetector = null;
    if (controller != null) {
      await controller!.dispose();
      controller = null;
      isCameraInitialized = false;
    }
  }

  // Live frame processing

  Future<void> _processCameraFrame(CameraImage cameraImage) async {
    if (_isDetecting || isCapturingPhoto || isProcessingCapture) return;
    if (_streamFaceDetector == null) return;
    _isDetecting = true;

    try {
      final inputImage = _buildInputImage(cameraImage);
      if (inputImage == null) {
        _isDetecting = false;
        return;
      }
      final faces = await _streamFaceDetector!.processImage(inputImage);

      imageSize = Size(
        cameraImage.width.toDouble(),
        cameraImage.height.toDouble(),
      );
      detectedFaces = faces;

      final nowDetected = faces.isNotEmpty;

      if (nowDetected && !faceDetected) {
        faceDetected = true;
        notifyListeners();
        _startCountdown();
      } else if (!nowDetected && faceDetected) {
        faceDetected = false;
        _cancelCountdown();
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (_) {
      // silently ignore per-frame errors
    } finally {
      _isDetecting = false;
    }
  }

  InputImage? _buildInputImage(CameraImage cameraImage) {
    if (controller == null) return null;
    final sensorOrientation = controller!.description.sensorOrientation;

    InputImageRotation rotation;
    if (Platform.isIOS) {
      rotation =
          InputImageRotationValue.fromRawValue(sensorOrientation) ??
          InputImageRotation.rotation0deg;
    } else {
      final orientations = {
        DeviceOrientation.portraitUp: 0,
        DeviceOrientation.landscapeLeft: 90,
        DeviceOrientation.portraitDown: 180,
        DeviceOrientation.landscapeRight: 270,
      };
      final deviceRot = orientations[controller!.value.deviceOrientation] ?? 0;
      final rotCompensation = (sensorOrientation - deviceRot + 360) % 360;
      rotation =
          InputImageRotationValue.fromRawValue(rotCompensation) ?? InputImageRotation.rotation0deg;
    }

    final format = InputImageFormatValue.fromRawValue(cameraImage.format.raw);
    if (format == null) return null;

    final plane = cameraImage.planes.first;
    return InputImage.fromBytes(
      bytes: plane.bytes,
      metadata: InputImageMetadata(
        size: Size(
          cameraImage.width.toDouble(),
          cameraImage.height.toDouble(),
        ),
        rotation: rotation,
        format: format,
        bytesPerRow: plane.bytesPerRow,
      ),
    );
  }

  // Countdown

  void _startCountdown() {
    if (countdownValue != null) return;
    countdownValue = 3;
    notifyListeners();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdownValue == null) {
        timer.cancel();
        return;
      }
      countdownValue = countdownValue! - 1;
      notifyListeners();
      if (countdownValue! <= 0) {
        timer.cancel();
        countdownValue = null;
        _captureCurrentAngle();
      }
    });
  }

  void _cancelCountdown() {
    _countdownTimer?.cancel();
    _countdownTimer = null;
    countdownValue = null;
    notifyListeners();
  }

  // Capture

  /// Manual capture — interrupts any running countdown.
  Future<void> manualCapture() async {
    if (isCapturingPhoto || isProcessingCapture) return;
    _cancelCountdown();
    await _captureCurrentAngle();
  }

  Future<void> _captureCurrentAngle() async {
    if (controller == null || !controller!.value.isInitialized) return;
    if (isCapturingPhoto || isProcessingCapture) return;

    // Wait for any in-progress frame detection to finish (max 500 ms)
    int waitMs = 0;
    while (_isDetecting && waitMs < 500) {
      await Future.delayed(const Duration(milliseconds: 50));
      waitMs += 50;
    }

    // Stop image stream safely — ignore errors (e.g. stream already stopped)
    try {
      await _stopImageStream();
    } catch (e) {
      debugPrint('[SelfieProvider] stopImageStream error (ignored): $e');
    }

    isCapturingPhoto = true;
    notifyListeners();

    XFile? photo;
    try {
      photo = await controller!.takePicture();
    } catch (e) {
      debugPrint('[SelfieProvider] takePicture error: $e');
      isCapturingPhoto = false;
      try {
        await _startImageStream();
      } catch (_) {}
      notifyListeners();
      return;
    }
    isCapturingPhoto = false;
    isProcessingCapture = true;
    notifyListeners();

    final angle = currentAngle;
    try {
      final result = await faceEmbeddingService.processImage(photo);

      if (result != null) {
        capturedPhotos[angle.value] = result.croppedFace;
        capturedEmbeddings[angle.value] = result.embedding;
        if (angle == SelfieAngle.front) selfieImage = result.croppedFace;
      } else {
        capturedPhotos[angle.value] = photo;
        capturedEmbeddings[angle.value] = List.filled(192, 0.0);
        if (angle == SelfieAngle.front) selfieImage = photo;
      }
    } catch (e) {
      // TFLite / ML Kit error — store raw photo with empty embedding so user
      // can still proceed rather than being silently stuck.
      debugPrint('[SelfieProvider] processImage error (using fallback): $e');
      capturedPhotos[angle.value] = photo;
      capturedEmbeddings[angle.value] = List.filled(192, 0.0);
      if (angle == SelfieAngle.front) selfieImage = photo;
    } finally {
      // Advance step regardless of ML result
      if (currentAngleIndex < SelfieAngle.values.length - 1) {
        currentAngleIndex++;
        faceDetected = false;
        detectedFaces = [];
      } else {
        allCaptured = true;
      }
      isProcessingCapture = false;
      notifyListeners();
    }

    if (!allCaptured) {
      try {
        await _startImageStream();
      } catch (_) {}
    }
  }

  // Retake

  Future<void> retakeAngle(SelfieAngle angle) async {
    capturedPhotos.remove(angle.value);
    capturedEmbeddings.remove(angle.value);
    allCaptured = false;
    currentAngleIndex = SelfieAngle.values.indexOf(angle);
    faceDetected = false;
    detectedFaces = [];
    submitErrors.clear();
    notifyListeners();
    // Re-initialize camera if it was disposed (e.g. app backgrounded)
    if (controller == null || !controller!.value.isInitialized) {
      await initializeCamera(cameraLensDirection: CameraLensDirection.front);
    } else {
      await _startImageStream();
    }
  }

  /// Resets all captured data and restarts the camera stream from angle 0.
  Future<void> resetAll() async {
    _cancelCountdown();
    capturedPhotos.clear();
    capturedEmbeddings.clear();
    allCaptured = false;
    currentAngleIndex = 0;
    faceDetected = false;
    detectedFaces = [];
    submitErrors.clear();
    notifyListeners();
    // Re-initialize camera if it was disposed, otherwise just restart stream
    if (controller == null || !controller!.value.isInitialized) {
      await initializeCamera(cameraLensDirection: CameraLensDirection.front);
    } else {
      await _startImageStream();
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
      (_) {
        notifyListeners();
        return null;
      },
    );
  }

  void resetCamera() => notifyListeners();

  @override
  void dispose() {
    _cancelCountdown();
    _streamFaceDetector?.close();
    controller?.dispose();
    controller = null;
    faceEmbeddingService.dispose();
    super.dispose();
  }
}
