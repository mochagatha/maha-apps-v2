import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../core/router/route_names.dart';

class SelfiePage extends StatelessWidget {
  const SelfiePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Formulir Data Diri'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(
                  color: Color(0xffF1F1F1), // AppColors.thirdColor approximation
                  height: 20,
                  thickness: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Ambil Foto Selfie',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Lengkapi proses ini dengan mengambil foto wajah Anda. Pastikan wajah terlihat jelas, ya.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      Image.asset(
                        'assets/images/icon/selfie.png',
                        width: MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.width - 50,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const HeaderScrollSelfie(step: 6),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text('Kembali', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  context.pushNamed(RouteNames.selfieCamera);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Mulai Ambil Foto', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    SizedBox(width: 8),
                    Icon(Icons.camera_alt_outlined, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderScrollSelfie extends StatelessWidget {
  final int step;
  const HeaderScrollSelfie({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                 _checkContract(isActive: true, number: 1, title: "Biodata"),
                 _checkContract(isActive: true, number: 2, title: "Riwayat Pendidikan"),
                 _checkContract(isActive: true, number: 3, title: "Data Keluarga"),
                 _checkContract(isActive: true, number: 4, title: "Kelengkapan Dokumen"),
                 _checkContract(isActive: true, number: 5, title: "Keahlian"),
                 _checkContract(isActive: step >= 6, number: 6, title: "Ambil Foto Selfie"),
                 _checkContract(isActive: step >= 7, number: 7, title: "Ambil Foto Selfie dengan KTP"),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
    Widget _checkContract({required int number, required String title, bool isActive = false}) {
      return Row( 
        children: [
            if (number != 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    width: 40,
                    height: 3,
                    color: isActive ? const Color(0xffFDE0D1) : AppColors.secondary,
                  ),
                ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                 shape: BoxShape.circle,
                color: isActive ? AppColors.primary : Colors.white,
                border: Border.all(color: isActive ? AppColors.primary : AppColors.secondary),
              ),
              child: Center(
                child: Text(
                  number.toString(),
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: isActive ? AppColors.primary : AppColors.secondary,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
        ],
      );
  }
}
