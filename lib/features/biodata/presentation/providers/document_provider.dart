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

  Future<void> submit() async {
     print("Submitting Documents: $selectedFiles");
     // Logic to validate required files
     // Required: photo, ktp, kk, rekening, ijazah
     final requiredKeys = ['photo', 'ktp', 'kk', 'rekening', 'ijazah'];
     for (var key in requiredKeys) {
       if (selectedFiles[key] == null) {
         print("Validation Error: $key is missing");
         return; // Show error in UI
       }
     }
     
     // Proceed to upload
  }
}
