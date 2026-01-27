import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import '../../../../core/widgets/face_detector_painter.dart';

enum FaceState { detecting, eyesClosed, waitingOpen, captured }

class AdminFaceProvider extends ChangeNotifier {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  int _cameraIndex = -1;
  bool _isCameraInitialized = false;

  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableClassification: true,
      enableContours: false,
      enableLandmarks: false,
      performanceMode: FaceDetectorMode.fast,
    ),
  );

  FaceState _faceState = FaceState.detecting;

  bool _isImageSaved = false;
  String? _imagePath;
  String? _errorMessage;

  CustomPaint? _customPaint;

  DateTime _lastProcess = DateTime.now();

  CameraController? get cameraController => _cameraController;
  bool get isCameraInitialized => _isCameraInitialized;
  CustomPaint? get customPaint => _customPaint;
  bool get isImageSaved => _isImageSaved;
  String? get imagePath => _imagePath;
  String? get errorMessage => _errorMessage;

  AdminFaceProvider() {
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      _cameras = await availableCameras();

      for (var i = 0; i < _cameras.length; i++) {
        if (_cameras[i].lensDirection == CameraLensDirection.front) {
          _cameraIndex = i;
          break;
        }
      }

      if (_cameraIndex == -1) {
        throw Exception('Front camera not found');
      }

      await _startLiveFeed();
    } catch (e) {
      _errorMessage = 'Camera init error: $e';
      notifyListeners();
    }
  }

  Future<void> _startLiveFeed() async {
    final camera = _cameras[_cameraIndex];

    _cameraController = CameraController(
      camera,
      ResolutionPreset.low,
      enableAudio: false,
      imageFormatGroup: Platform.isAndroid ? ImageFormatGroup.nv21 : ImageFormatGroup.bgra8888,
    );

    await _cameraController!.initialize();
    _isCameraInitialized = true;

    await _cameraController!.startImageStream(_processCameraImage);
    notifyListeners();
  }

  void _processCameraImage(CameraImage image) async {
    final now = DateTime.now();
    if (now.difference(_lastProcess).inMilliseconds < 80) return;
    _lastProcess = now;

    if (_faceState == FaceState.captured) return;

    final inputImage = _inputImageFromCameraImage(image);
    if (inputImage == null) return;

    final faces = await _faceDetector.processImage(inputImage);

    if (inputImage.metadata?.size != null && inputImage.metadata?.rotation != null) {
      final painter = FaceDetectorPainter(
        faces,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        CameraLensDirection.front,
      );

      _customPaint = CustomPaint(painter: painter);
    }

    if (faces.isNotEmpty) {
      await _processBlink(faces.first);
    }

    notifyListeners();
  }

  Future<void> _processBlink(Face face) async {
    const double closeThreshold = 0.35;
    const double openThreshold = 0.65;

    final left = face.leftEyeOpenProbability ?? 1.0;
    final right = face.rightEyeOpenProbability ?? 1.0;

    final bothClosed = left < closeThreshold && right < closeThreshold;
    final bothOpen = left > openThreshold && right > openThreshold;

    switch (_faceState) {
      case FaceState.detecting:
        if (bothClosed) {
          _faceState = FaceState.eyesClosed;
        }
        break;

      case FaceState.eyesClosed:
        if (bothOpen) {
          _faceState = FaceState.waitingOpen;
          await _triggerCapture();
        }
        break;

      case FaceState.waitingOpen:
      case FaceState.captured:
        break;
    }
  }

  Future<void> _triggerCapture() async {
    if (_isImageSaved) return;

    _isImageSaved = true;
    _faceState = FaceState.captured;

    try {
      await Future.delayed(const Duration(milliseconds: 150));

      if (_cameraController?.value.isStreamingImages == true) {
        await _cameraController?.stopImageStream();
      }

      await Future.delayed(const Duration(milliseconds: 120));

      final XFile file = await _cameraController!.takePicture();
      _imagePath = file.path;

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Capture error: $e';
      resetVerification();
    }
  }

  InputImage? _inputImageFromCameraImage(CameraImage image) {
    if (_cameraController == null) return null;

    final camera = _cameras[_cameraIndex];
    final sensorOrientation = camera.sensorOrientation;

    InputImageRotation? rotation;

    if (Platform.isIOS) {
      rotation = InputImageRotationValue.fromRawValue(sensorOrientation);
    } else {
      final orientations = {
        DeviceOrientation.portraitUp: 0,
        DeviceOrientation.landscapeLeft: 90,
        DeviceOrientation.portraitDown: 180,
        DeviceOrientation.landscapeRight: 270,
      };

      var rotationCompensation = orientations[_cameraController!.value.deviceOrientation] ?? 0;

      if (camera.lensDirection == CameraLensDirection.front) {
        rotationCompensation = (sensorOrientation + rotationCompensation) % 360;
      } else {
        rotationCompensation = (sensorOrientation - rotationCompensation + 360) % 360;
      }

      rotation = InputImageRotationValue.fromRawValue(rotationCompensation);
    }

    if (rotation == null) return null;

    // 🔥 Convert YUV_420_888 → NV21
    final bytes = _yuv420ToNv21(image);

    return InputImage.fromBytes(
      bytes: bytes,
      metadata: InputImageMetadata(
        size: Size(image.width.toDouble(), image.height.toDouble()),
        rotation: rotation,
        format: InputImageFormat.nv21,
        bytesPerRow: image.width,
      ),
    );
  }

  Uint8List _yuv420ToNv21(CameraImage image) {
    final int width = image.width;
    final int height = image.height;

    final yPlane = image.planes[0];
    final uPlane = image.planes[1];
    final vPlane = image.planes[2];

    final int ySize = width * height;
    final int uvSize = ySize ~/ 2;

    final Uint8List nv21 = Uint8List(ySize + uvSize);

    // Copy Y plane
    int yIndex = 0;
    for (int row = 0; row < height; row++) {
      nv21.setRange(yIndex, yIndex + width, yPlane.bytes, row * yPlane.bytesPerRow);
      yIndex += width;
    }

    // Interleave V and U
    int uvIndex = ySize;
    for (int row = 0; row < height ~/ 2; row++) {
      int uvRowStart = row * uPlane.bytesPerRow;
      for (int col = 0; col < width; col += 2) {
        nv21[uvIndex++] = vPlane.bytes[uvRowStart + col];
        nv21[uvIndex++] = uPlane.bytes[uvRowStart + col];
      }
    }

    return nv21;
  }

  void resetVerification() {
    _faceState = FaceState.detecting;
    _isImageSaved = false;
    _imagePath = null;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    if (_cameraController?.value.isStreamingImages == true) {
      _cameraController?.stopImageStream();
    }
    _cameraController?.dispose();
    _faceDetector.close();
    super.dispose();
  }
}
