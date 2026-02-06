import 'dart:io';
import 'package:flutter/material.dart';
import 'package:maha_apps_v2/core/router/route_names.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
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
                  if (provider.selfieImage == null ||
                      provider.selfieKtpImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Foto selfie dan foto selfie dengan KTP harus diambil!',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // Submit Data and Finish
                  showDialog(
                    context: context,
                    builder: (context) => _SuccessPopup(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Unggah Foto',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'Ambil Ulang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessPopup extends StatelessWidget {
  const _SuccessPopup();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Data diri berhasil dikirim!",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Image.asset(
              "assets/images/icon/verifikasi-data.png",
              height: 150,
            ),
            SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Mohon untuk menunggu "),
                  TextSpan(
                    text: "Verifikasi Data Diri",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " Anda dari HRD Maha!"),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context.goNamed(RouteNames.biodataBank);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/icon/whatsapp.png",
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 8),
                  const Text(
                    'Hubungi Admin',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
