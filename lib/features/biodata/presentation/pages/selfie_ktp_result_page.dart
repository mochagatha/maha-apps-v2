import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../providers/selfie_provider.dart';

class SelfieKtpResultPage extends StatelessWidget {
  const SelfieKtpResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SelfieProvider>();
    final imageFile = provider.selfieKtpImage;

    if (imageFile == null) {
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
                  // Validate both selfie images exist
                  if (provider.selfieImage == null || provider.selfieKtpImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Foto selfie dan foto selfie dengan KTP harus diambil!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Submit Data and Finish
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Konfirmasi"),
                      content: const Text("Apakah data yang anda masukkan sudah benar?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Batal")),
                        ElevatedButton(
                          onPressed: () {
                            // Mock Submission
                            Navigator.pop(ctx);
                            // Navigate to Home or Success Screen
                            // Assuming root for now or some dashboard
                            // context.goNamed(RouteNames.home);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Data Berhasil Disimpan!")),
                            );
                            // For demo purpose, maybe pop to root or biodata list
                          },
                          child: const Text("Ya, Simpan"),
                        ),
                      ],
                    ),
                  );
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
