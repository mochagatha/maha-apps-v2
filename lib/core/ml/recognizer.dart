import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';
import 'recognition_embedding.dart';

/// Face recognition service using TensorFlow Lite MobileFaceNet model
class Recognizer {
  late Interpreter interpreter;
  late InterpreterOptions _interpreterOptions;

  /// Input image dimensions for the model
  static const int WIDTH = 112;
  static const int HEIGHT = 112;

  /// Path to the TFLite model asset
  String get modelName => 'assets/mobile_face_net.tflite';

  /// Load the TensorFlow Lite model
  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset(modelName);
    } catch (e) {
      // Model loading failed - handle silently
    }
  }

  /// Initialize the recognizer with optional thread count
  Recognizer({int? numThreads}) {
    _interpreterOptions = InterpreterOptions();

    if (numThreads != null) {
      _interpreterOptions.threads = numThreads;
    }
    loadModel();
  }

  /// Convert image to normalized array for model input
  List<dynamic> imageToArray(img.Image inputImage) {
    img.Image resizedImage = img.copyResize(inputImage, width: WIDTH, height: HEIGHT);
    List<double> flattenedList = resizedImage.data!
        .expand((channel) => [channel.r, channel.g, channel.b])
        .map((value) => value.toDouble())
        .toList();
    Float32List float32Array = Float32List.fromList(flattenedList);
    int channels = 3;
    int height = HEIGHT;
    int width = WIDTH;
    Float32List reshapedArray = Float32List(1 * height * width * channels);
    for (int c = 0; c < channels; c++) {
      for (int h = 0; h < height; h++) {
        for (int w = 0; w < width; w++) {
          int index = c * height * width + h * width + w;
          reshapedArray[index] = (float32Array[c * height * width + h * width + w] - 127.5) / 127.5;
        }
      }
    }
    return reshapedArray.reshape([1, 112, 112, 3]);
  }

  /// Extract face embedding from image
  RecognitionEmbedding recognize(img.Image image, Rect location) {
    var input = imageToArray(image);

    List output = List.filled(1 * 192, 0).reshape([1, 192]);

    interpreter.run(input, output);

    List<double> outputArray = output.first.cast<double>();

    return RecognitionEmbedding(location, outputArray);
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
