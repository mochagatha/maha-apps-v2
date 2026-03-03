import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'recognition_embedding.dart';

/// Face recognition service using TensorFlow Lite MobileFaceNet model
class Recognizer {
  Interpreter? _interpreter;
  late InterpreterOptions _interpreterOptions;

  bool get isLoaded => _interpreter != null;

  /// Input image dimensions for the model
  static const int WIDTH = 112;
  static const int HEIGHT = 112;

  /// Path to the TFLite model asset
  String get modelName => 'assets/models/mobile_face_net.tflite';

  /// Load the TensorFlow Lite model.
  /// Throws [Exception] if the model asset cannot be loaded.
  Future<void> loadModel() async {
    _interpreter?.close();
    _interpreter = null;
    final interp = await Interpreter.fromAsset(
      modelName,
      options: _interpreterOptions,
    );
    _interpreter = interp;
    debugPrint(
      '[Recognizer] Model loaded. '
      'Input: ${interp.getInputTensors().map((t) => t.shape)}, '
      'Output: ${interp.getOutputTensors().map((t) => t.shape)}',
    );
  }

  /// Initialize the recognizer with optional thread count.
  /// Do NOT call loadModel() here — use [FaceEmbeddingService.initialize()] which awaits it.
  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
  }

  /// Release interpreter resources.
  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }

  /// Convert image to normalized array for model input.
  /// MobileFaceNet expects [1, H, W, 3] NHWC layout with values in [-1, 1].
  List<dynamic> imageToArray(img.Image inputImage) {
    final img.Image resized = img.copyResize(inputImage, width: WIDTH, height: HEIGHT);

    // Build flat HWC list: [r00,g00,b00, r01,g01,b01, ..., r(H-1)(W-1)...]
    final Float32List input = Float32List(HEIGHT * WIDTH * 3);
    int idx = 0;
    for (int h = 0; h < HEIGHT; h++) {
      for (int w = 0; w < WIDTH; w++) {
        final pixel = resized.getPixel(w, h);
        input[idx++] = (pixel.r.toDouble() - 127.5) / 127.5;
        input[idx++] = (pixel.g.toDouble() - 127.5) / 127.5;
        input[idx++] = (pixel.b.toDouble() - 127.5) / 127.5;
      }
    }
    return input.reshape([1, HEIGHT, WIDTH, 3]);
  }

  /// Extract face embedding from image.
  /// Throws [StateError] if the model has not been loaded yet.
  RecognitionEmbedding recognize(img.Image image, Rect location) {
    try {
      final interp = _interpreter;
      if (interp == null) {
        throw StateError('[Recognizer] Model not loaded — call loadModel() first.');
      }

      final input = imageToArray(image);

      // Use runForMultipleInputs with Map<int, Object> — the canonical
      // tflite_flutter pattern that avoids Float32List vs List<double> type errors.
      // Output tensor shape is [1, 192] — wrap in a List to match
      final List<List<double>> outputBuffer = [List<double>.filled(192, 0.0)];
      final outputs = <int, Object>{0: outputBuffer};

      interp.runForMultipleInputs([input], outputs);

      final embedding = outputBuffer[0];
      debugPrint('[Recognizer] Embedding sample (first 5): ${embedding.take(5).toList()}');

      // L2-normalize embedding to unit length
      double sum = 0.0;
      for (var v in embedding) {
        sum += v * v;
      }
      final norm = sqrt(sum);
      if (norm > 0.0) {
        for (int i = 0; i < embedding.length; i++) {
          embedding[i] = embedding[i] / norm;
        }
      }

      return RecognitionEmbedding(location, embedding);
    } catch (e) {
      debugPrint('[Recognizer] Error recognizing face: $e');
      rethrow;
    }
  }

  /// Find the nearest match between two embeddings
  PairEmbedding findNearest(List<double> emb, List<double> authFaceEmbedding) {
    PairEmbedding pair = PairEmbedding(-5);

    double distance = 0;
    for (int i = 0; i < emb.length; i++) {
      double diff = emb[i] - authFaceEmbedding[i];
      distance += diff * diff;
    }
    distance = sqrt(distance);
    if (pair.distance == -5 || distance < pair.distance) {
      pair.distance = distance;
    }
    return pair;
  }

  /// Validate if the face matches the stored embedding
  /// Returns true if the face is valid (distance < 1.0)
  Future<bool> isValidFace(List<double> emb) async {
    final prefs = await SharedPreferences.getInstance();
    final embeddingStorage = prefs.getString('face_embedding');

    if (embeddingStorage == null || embeddingStorage.isEmpty) {
      return false;
    }

    PairEmbedding pair = findNearest(
      emb,
      embeddingStorage.split(',').map((e) => double.parse(e)).toList().cast<double>(),
    );

    // Threshold for face matching (lower = more similar)
    if (pair.distance < 1.0) {
      return true;
    }
    return false;
  }
}

/// Represents a pair of embeddings with their distance
class PairEmbedding {
  double distance;
  PairEmbedding(this.distance);
}
