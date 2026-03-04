import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';

import '../../domain/usecases/submit_signature.dart';

class SignatureProvider extends ChangeNotifier {
  final SubmitSignature submitSignatureUseCase;
  final SharedPreferences sharedPreferences;

  SignatureProvider({
    required this.submitSignatureUseCase,
    required this.sharedPreferences,
  });

  final signatureController = SignatureController(
    penStrokeWidth: 8,
    penColor: Colors.black,
    exportBackgroundColor: Colors.transparent,
  );

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  Future<String?> submit() async {
    if (signatureController.isEmpty) {
      return "Tanda tangan tidak boleh kosong";
    }

    final employeeId = sharedPreferences.getInt('employee_id');
    if (employeeId == null) {
      return "ID karyawan tidak ditemukan";
    }

    // Export signature directly as PNG bytes
    final pngBytes = await signatureController.toPngBytes();
    if (pngBytes == null) {
      return "Gagal mengekspor tanda tangan";
    }

    // Save PNG to temp directory
    final tempDir = await getTemporaryDirectory();
    final pngFile = File('${tempDir.path}/signature_$employeeId.png');
    await pngFile.writeAsBytes(pngBytes);

    // Upload via use case
    final result = await submitSignatureUseCase(
      SubmitSignatureParams(
        employeeId: employeeId,
        signaturePath: pngFile.path,
      ),
    );

    // Clean up temp file
    try {
      await pngFile.delete();
    } catch (_) {}

    return result.fold(
      (failure) => failure.message,
      (_) => null,
    );
  }
}
