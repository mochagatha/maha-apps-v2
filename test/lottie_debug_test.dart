import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Inspect Lottie Layers', () async {
    final file = File(
      'd:\\Workspace\\Dart\\Flutter\\Maha\\maha-apps-v2\\assets\\splash_modified.json',
    );
    if (!await file.exists()) {
      print('File not found: ${file.path}');
      return;
    }

    final content = await file.readAsString();
    final Map<String, dynamic> json = jsonDecode(content);

    print('Lottie Dimensions: ${json['w']}x${json['h']}');
    final layers = json['layers'] as List;
    print('Found ${layers.length} layers:');

    for (var i = 0; i < layers.length; i++) {
      final layer = layers[i];
      print('Layer $i: Type=${layer['ty']}, Name="${layer['nm']}"');
      if (layer['ty'] == 1) {
        // Solid
        print('  -> Solid Color: ${layer['sc']}');
      }
    }
  });
}
