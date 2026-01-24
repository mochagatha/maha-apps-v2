import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../../../shared/theme/app_theme.dart';

class WelcomeDialogs {
  static void showWelcomeGreetingDialog({
    required BuildContext context,
    required VoidCallback onNext,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Selamat Bergabung !',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  SvgPicture.asset("assets/images/icon/selamat_bergabung.svg", height: 200),
                  const SizedBox(height: 20),
                  const Text(
                    'Semoga Anda dapat memberikan kontribusi terbaik bagi perusahaan PT. Maha Akbar Sejahtera.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text('Direktur', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Hazri Fadillah Harahap, SE', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onNext();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: const Text(
                        'Selanjutnya',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showRegulationAgreementDialog({
    required BuildContext context,
    required VoidCallback onNext,
  }) {
    final ValueNotifier<bool> isAgree = ValueNotifier(false);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final screenSize = MediaQuery.of(context).size;
        final screenWidth = screenSize.width;

        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Peraturan Perusahaan !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('assets/images/icon/Peraturan Perusahaan.png', height: 200),
                  const Text.rich(
                    TextSpan(
                      text: 'Sebelum Anda melanjutkan ke tahap ',
                      children: [
                        TextSpan(
                          text: 'pengisian data',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text:
                              '. Harap baca terlebih dahulu peraturan PT. Maha Akbar Sejahtera...!',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade100,
                    ),
                    child: Row(
                      children: [
                        ValueListenableBuilder<bool>(
                          valueListenable: isAgree,
                          builder: (context, value, child) {
                            return Checkbox(
                              activeColor: Colors.red,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              value: value,
                              onChanged: (newValue) {
                                isAgree.value = newValue!;
                              },
                            );
                          },
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              isAgree.value = !isAgree.value;
                            },
                            child: const Text(
                              'Dengan ini saya menyatakan bahwa saya menyetujui seluruh peraturan perusahaan',
                              style: TextStyle(fontSize: 10, color: Colors.black54),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            final baseUrl =
                                dotenv.env['BASE_URL_PUBLIC'] ??
                                'https://public.maha-akbar.com'; // Fallback
                            await launchUrl(Uri.parse("$baseUrl/assets/doc/peraturan.pdf"));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.print, size: 14, color: Colors.white),
                              const SizedBox(width: 2.5),
                              Text(
                                'Unduh',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth < 360 ? 12 : 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: ValueListenableBuilder<bool>(
                          valueListenable: isAgree,
                          builder: (context, value, child) {
                            return ElevatedButton(
                              onPressed: value
                                  ? () {
                                      Navigator.of(context).pop();
                                      onNext();
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              child: Text(
                                'Lanjutkan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth < 360 ? 12 : 14,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showDataCompletionPromptDialog({
    required BuildContext context,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Lengkapi Data diri Anda !',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Image.asset('assets/images/icon/fill-biodata.png', height: 200),
                  const SizedBox(height: 20),
                  const Text.rich(
                    TextSpan(
                      text: 'Dalam pengisian formulir ini, Anda membutuhkan waktu ',
                      children: [
                        TextSpan(
                          text: '10 Menit',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: '. Harap diisi dengan sejujurnya yah !'),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text('Semangat', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Be Great, Be Integrated', style: TextStyle(fontSize: 12)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                      child: const Text(
                        'Oke',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
