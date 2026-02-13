import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';

class SignaturePage extends StatelessWidget {
  const SignaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Tanda Tangan"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Column(
          children: [
            Text(
              "Buat Tanda Tangan",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 12),
            Text(
              "Lengkapi proses ini dengan membuat tanda tangan Anda. Pastikan tanda tangan Anda jelas ya!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32),
            Image.asset(
              "assets/images/icon/welcome-signature.png",
              width: 270,
              height: 270,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: CustomElevatedButton(
          onPressed: () {
            context.pushReplacementNamed(AppRoutes.biodataCreateSignature.name);
          },
          child: Text("Mulai Buat Tanda Tangan"),
        ),
      ),
    );
  }
}
