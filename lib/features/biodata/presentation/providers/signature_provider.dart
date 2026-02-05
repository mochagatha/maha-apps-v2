import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

class SignatureProvider extends ChangeNotifier {
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

    // implement submit
    await Future.delayed(Duration(seconds: 1));
    return null;
  }
}
