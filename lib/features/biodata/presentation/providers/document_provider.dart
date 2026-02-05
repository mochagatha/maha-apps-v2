import 'package:flutter/material.dart';

class DocumentProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoadingData = false;

  Map<String, String?> selectedFiles = {
    'photo': null,
    'ktp': null,
    'kk': null,
    'rekening': null,
    'ijazah': null,
    'transkrip': null,
    'sertif_keahlian': null,
    'npwp': null,
    'bpjs_ketenagakerjaan': null,
    'bpjs_kesehatan': null,
  };

  void setFile(String key, String? path) {
    selectedFiles[key] = path;
    notifyListeners();
  }

  Future<String?> submit() async {
    // Validate required files
    // Required: photo, ktp, kk, rekening, ijazah
    final requiredKeys = ['photo', 'ktp', 'kk', 'rekening', 'ijazah'];
    for (var key in requiredKeys) {
      if (selectedFiles[key] == null || selectedFiles[key]!.isEmpty) {
        debugPrint("Validation Error: $key is missing");
        // You can add error message state here to show in UI
        return "Ada data yang kosong!";
      }
    }

    debugPrint("Submitting Documents: $selectedFiles");
    // Proceed to upload
    return null;
  }
}
