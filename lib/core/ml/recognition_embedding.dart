import 'package:flutter/material.dart';

/// Represents a face recognition embedding with location and feature vector
class RecognitionEmbedding {
  /// The bounding box location of the detected face
  final Rect location;
  
  /// The 192-dimensional feature vector representing the face
  final List<double> embedding;

  RecognitionEmbedding(this.location, this.embedding);
}
