import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../providers/selfie_provider.dart';

class SelfieResultPage extends StatelessWidget {
  const SelfieResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelfieProvider>();
    final imageFile = provider.selfieImage;

    if (imageFile == null) {
      // Fallback if no image (shouldn't happen in flow)
      return Scaffold(body: Center(child: Text("No image captured")));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Hasil Photo"),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Image.file(File(imageFile.path), fit: BoxFit.cover),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 140,
        elevation: 0,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Proceed to Selfie KTP
                  context.pushNamed(RouteNames.selfieKtpForm);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Unggah Foto',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  context.pop(); // Go back to camera
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Ambil Ulang',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
