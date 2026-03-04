import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

import 'recognizer.dart';

/// Result of face detection + embedding extraction on a single captured photo.
class FaceEmbeddingResult {
  /// The cropped & resized face image saved as a temp file (112×112 JPEG).
  final XFile croppedFace;

  /// 192-dimensional MobileFaceNet embedding vector.
  final List<double> embedding;

  const FaceEmbeddingResult({required this.croppedFace, required this.embedding});
}

/// Stateful service that wraps ML Kit FaceDetector + MobileFaceNet TFLite.
/// Call [initialize] once and [dispose] when done.
class FaceEmbeddingService {
  late final FaceDetector _faceDetector;
  late final Recognizer _recognizer;
  bool _isInitialized = false;

  Future<void> initialize() async {
    if (_isInitialized) return;
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        performanceMode: FaceDetectorMode.accurate,
        enableLandmarks: false,
        enableClassification: false,
        minFaceSize: 0.15,
      ),
    );
    _recognizer = Recognizer(numThreads: 2);
    // loadModel() now throws on failure — let the caller handle it.
    await _recognizer.loadModel();
    _isInitialized = true;
    debugPrint('[FaceEmbeddingService] Initialized.');
  }

  void dispose() {
    if (_isInitialized) {
      _faceDetector.close();
      _recognizer.dispose();
      _isInitialized = false;
    }
  }

  /// Detects faces in [imageFile] using ML Kit (still-image mode).
  /// Returns the list of detected [Face]s.
  Future<List<Face>> detectFaces(XFile imageFile) async {
    if (!_isInitialized) await initialize();
    final inputImage = InputImage.fromFilePath(imageFile.path);
    return await _faceDetector.processImage(inputImage);
  }

  /// Processes [imageFile]:
  /// 1. Detects faces — picks the largest bounding box.
  /// 2. Crops & normalises to 112×112.
  /// 3. Runs MobileFaceNet to produce a 192-dim embedding.
  ///
  /// Returns [FaceEmbeddingResult] or null if no face is detected.
  Future<FaceEmbeddingResult?> processImage(XFile imageFile) async {
    if (!_isInitialized) await initialize();

    // --- Step 1: Detect faces
    final faces = await detectFaces(imageFile);
    if (faces.isEmpty) {
      debugPrint('[FaceEmbeddingService] No face detected in ${imageFile.path}');
      return null;
    }

    // Pick the face with the largest bounding box
    final bestFace = faces.reduce(
      (a, b) => _area(a.boundingBox) >= _area(b.boundingBox) ? a : b,
    );

    // --- Step 2: Decode & crop
    final bytes = await File(imageFile.path).readAsBytes();
    final original = img.decodeImage(Uint8List.fromList(bytes));
    if (original == null) return null;

    final bb = bestFace.boundingBox;

    // Add 20 % padding around the bounding box for better embedding quality
    final padX = (bb.width * 0.2).toInt();
    final padY = (bb.height * 0.2).toInt();

    final x = (bb.left.toInt() - padX).clamp(0, original.width - 1);
    final y = (bb.top.toInt() - padY).clamp(0, original.height - 1);
    final w = (bb.width.toInt() + padX * 2).clamp(1, original.width - x);
    final h = (bb.height.toInt() + padY * 2).clamp(1, original.height - y);

    final cropped = img.copyCrop(original, x: x, y: y, width: w, height: h);
    final resized = img.copyResize(cropped, width: 112, height: 112);

    // --- Step 3: TFLite inference
    final recognitionResult = _recognizer.recognize(
      resized,
      Rect.fromLTWH(bb.left, bb.top, bb.width, bb.height),
    );

    // Save the normalized cropped face (112x112 JPEG) as a temp file
    // and return it so callers upload the normalized image.
    // final jpg = img.encodeJpg(resized, quality: 90);
    // final tempDir = Directory.systemTemp;
    // final tempFile = File('${tempDir.path}/face_${DateTime.now().millisecondsSinceEpoch}.jpg');
    // await tempFile.writeAsBytes(jpg);
    // XFile(tempFile.path);

    return FaceEmbeddingResult(
      croppedFace: imageFile,
      embedding: recognitionResult.embedding,
    );
  }

  double _area(Rect r) => r.width * r.height;
}
