import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../providers/forgot_password_provider.dart';
import '../pages/verification_code_page.dart';

class SelectMethodVerificationDialog extends StatelessWidget {
  final String email;

  const SelectMethodVerificationDialog({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Pilih Metode Verifikasi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Pilih salah satu metode dibawah ini untuk mendapatkan kode verifikasi',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                Navigator.pop(context); // Close dialog first
                _showLoadingDialog(context);

                final provider = context.read<ForgotPasswordProvider>();
                await provider.sendOtp(email);

                if (context.mounted) {
                  Navigator.pop(context); // Close loading
                  if (provider.state == ForgotPasswordState.success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerificationCodePage(email: email)),
                    );
                  } else if (provider.state == ForgotPasswordState.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(provider.errorMessage ?? 'Gagal mengirim OTP')),
                    );
                  }
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 1, blurRadius: 5),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // Placeholder icon if pes_verifikasi_otp.svg not available or use mail icon
                      child: const Icon(Icons.email, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('E-mail ke', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(
                            email,
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 20),
                Text('Sedang mengirim OTP...', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }
}
