import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../shared/theme/app_theme.dart';

class VerificationErrorDialog extends StatelessWidget {
  const VerificationErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Colors.blue,
          width: 2,
        ), // Dotted line simulation if needed, but solid blue for now as per image border hint
      ),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Maaf Sebelumnya!', // TODO: Localize
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),
          Image.asset(
            'assets/images/icon/success-register.png',
            height: 120,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.support_agent,
              size: 80,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
                fontFamily: 'Poppins',
              ),
              children: [
                const TextSpan(text: 'Akun Anda belum '), // TODO: Localize
                const TextSpan(
                  text: 'terverifikasi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(text: '. Silahkan\nhubungi '), // TODO: Localize
                const TextSpan(
                  text: 'HRD',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(text: ' Maha segera !'), // TODO: Localize
              ],
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final Uri whatsapp = Uri.parse(
                  "https://wa.me/6281364993863?text=${Uri.encodeComponent('Halo Admin, Saya ingin konfirmasi pendaftaran akun Maha Apps saya.')}",
                );
                if (await canLaunchUrl(whatsapp)) {
                  launchUrl(whatsapp);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914), // Red color
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/icon/whatsapp.png',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Hubungi Admin', // TODO: Localize
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
