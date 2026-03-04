import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/router/app_routes.dart';
import '../../domain/services/biodata_step_manager.dart';
import '../../domain/usecases/submit_document.dart';

class DocumentProvider extends ChangeNotifier {
  final SubmitDocument submitDocumentUseCase;

  DocumentProvider({required this.submitDocumentUseCase});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoadingData = false;
  bool isSubmitting = false;

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
    // Validate required files: photo, ktp, kk, certificate (ijazah), grade_transcript (transkrip)
    const requiredKeys = ['photo', 'ktp', 'kk', 'ijazah', 'transkrip'];
    for (final key in requiredKeys) {
      if (selectedFiles[key] == null || selectedFiles[key]!.isEmpty) {
        debugPrint("Validation Error: $key is missing");
        return "Ada data yang kosong!";
      }
    }

    // Retrieve employee_id from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final employeeId = prefs.getInt('employee_id');
    if (employeeId == null) {
      return "Employee ID tidak ditemukan. Silakan login ulang.";
    }

    isSubmitting = true;
    notifyListeners();

    try {
      final params = SubmitDocumentParams(
        employeeId: employeeId,
        photoPath: selectedFiles['photo']!,
        ktpPath: selectedFiles['ktp']!,
        kkPath: selectedFiles['kk']!,
        certificatePath: selectedFiles['ijazah']!,
        gradeTranscriptPath: selectedFiles['transkrip']!,
        certificateSkillPath: selectedFiles['sertif_keahlian'],
        bankAccountPath: selectedFiles['rekening'],
        npwpPath: selectedFiles['npwp'],
        bpjsKtnPath: selectedFiles['bpjs_ketenagakerjaan'],
        bpjsKesPath: selectedFiles['bpjs_kesehatan'],
      );

      final result = await submitDocumentUseCase(params);

      return result.fold(
        (failure) => failure.message,
        (_) {
          // Save the next step on success
          BiodataStepManager.setNextStep(AppRoutes.skillForm.path);
          return null;
        },
      );
    } catch (e) {
      return "Terjadi kesalahan: $e";
    } finally {
      isSubmitting = false;
      notifyListeners();
    }
  }
}
