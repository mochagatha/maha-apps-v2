import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../../../shared/widgets/error_dialog.dart';
import '../providers/forgot_password_provider.dart';
import '../pages/verification_code_page.dart';

class SelectMethodVerificationDialog extends StatefulWidget {
  final String email;

  const SelectMethodVerificationDialog({super.key, required this.email});

  @override
  State<SelectMethodVerificationDialog> createState() =>
      _SelectMethodVerificationDialogState();
}

class _SelectMethodVerificationDialogState
    extends State<SelectMethodVerificationDialog> {
  bool _isProcessing = false;

  Future<void> _handleSendOtp() async {
    // Prevent multiple taps
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
    });

    // Get root navigator before closing bottom sheet
    final rootNavigator = Navigator.of(context, rootNavigator: true);

    // Close method selection dialog (bottom sheet)
    Navigator.of(context).pop();

    // Wait a bit for bottom sheet animation to complete
    await Future.delayed(const Duration(milliseconds: 100));

    // Show loading dialog using root navigator context
    rootNavigator.push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: false,
        barrierColor: Colors.black54,
        pageBuilder: (BuildContext context, _, __) {
          return const LoadingDialog(message: 'Mengirim kode OTP...');
        },
      ),
    );

    try {
      final provider = context.read<ForgotPasswordProvider>();
      await provider.sendOtp(widget.email);

      // Remove the mounted check here because this widget (SelectMethodVerificationDialog)
      // is ALREADY popped/disposed above. So mounted will be false.
      // But we still need to close the loading dialog we opened on the rootNavigator.

      // Close loading dialog
      rootNavigator.pop();

      // Small delay to ensure loading dialog is fully closed
      await Future.delayed(const Duration(milliseconds: 50));

      if (provider.state == ForgotPasswordState.success) {
        // Show success dialog
        await showDialog(
          context: rootNavigator.context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SuccessDialog(
              title: 'OTP Terkirim',
              message: 'Kode verifikasi telah dikirim ke email ${widget.email}',
              onConfirm: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        VerificationCodePage(email: widget.email),
                  ),
                );
              },
            );
          },
        );
      } else if (provider.state == ForgotPasswordState.error) {
        // Show error dialog
        await showDialog(
          context: rootNavigator.context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return ErrorDialog(
              title: 'Gagal Mengirim OTP',
              message:
                  provider.errorMessage ??
                  'Email yang Anda masukkan tidak terdaftar atau terjadi kesalahan. Silakan coba lagi.',
            );
          },
        );
      } else {
        // Handle unexpected state
        await showDialog(
          context: rootNavigator.context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const ErrorDialog(
              title: 'Terjadi Kesalahan',
              message:
                  'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.',
            );
          },
        );
      }
    } catch (e) {
      // Also remove mounted check here
      rootNavigator.pop(); // Close loading

      await showDialog(
        context: rootNavigator.context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const ErrorDialog(
            title: 'Terjadi Kesalahan',
            message: 'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.',
          );
        },
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

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
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Pilih salah satu metode dibawah ini untuk mendapatkan kode verifikasi',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _isProcessing ? null : _handleSendOtp,
              child: Opacity(
                opacity: _isProcessing ? 0.5 : 1.0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 5,
                      ),
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
                        child: const Icon(
                          Icons.email,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'E-mail ke',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.email,
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
