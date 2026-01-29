import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../../../../shared/widgets/error_dialog.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/forgot_password_provider.dart';
import 'reset_password_page.dart';

class VerificationCodePage extends StatefulWidget {
  final String email;

  const VerificationCodePage({super.key, required this.email});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  Timer? _timer;
  int _start = 120; // 2 minutes
  bool isResendEnabled = false;

  // Custom OTP Input Controllers and FocusNodes
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void startTimer() {
    setState(() {
      isResendEnabled = false;
      _start = 120;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isResendEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get timerText {
    final minutes = (_start ~/ 60).toString().padLeft(2, '0');
    final seconds = (_start % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> _verifyCode() async {
    // Collect code from controllers
    String code = _controllers.map((e) => e.text).join();

    if (code.isEmpty || code.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mohon masukkan kode verifikasi yang valid'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    LoadingDialog.show(context, message: 'Memverifikasi kode OTP...');

    try {
      final provider = context.read<ForgotPasswordProvider>();
      await provider.verifyOtp(widget.email, code);

      if (!mounted) return;

      LoadingDialog.hide(context); // Close loading dialog

      if (provider.state == ForgotPasswordState.success) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResetPasswordPage()),
        );
      } else if (provider.state == ForgotPasswordState.error) {
        ErrorDialog.show(
          context,
          title: 'Kode OTP Salah',
          message:
              provider.errorMessage ??
              'Kode OTP yang Anda masukkan tidak sesuai. Silakan coba lagi.',
        );
      }
    } catch (e) {
      if (!mounted) return;
      LoadingDialog.hide(context);
      ErrorDialog.show(
        context,
        title: 'Terjadi Kesalahan',
        message: 'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.',
      );
    }
  }

  void _onFieldChanged(String value, int index) {
    if (value.isNotEmpty) {
      // Move to next field if not last
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        // Last field, unfocus and auto-verify
        _focusNodes[index].unfocus();
        _verifyCode();
      }
    } else {
      // Move to previous field on delete
      if (value.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Reset Kata Sandi',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: SvgPicture.asset(
                    "assets/images/icon/forgot_password.svg", // Using the same icon as per v1 implies, or pes_verifikasi_otp.svg if available
                    height: 150,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Masukkan Kode Verifikasi',
                  style: AppTextStyles.headingTwoSemiBold(
                    context,
                  ).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Kode verifikasi telah dikirim melalui e-mail ke ',
                    style: AppTextStyles.bodyStyle(
                      context,
                    ).copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: widget.email,
                        style: AppTextStyles.bodyStyle(context).copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Custom OTP Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60,
                      height: 60,
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          counterText: "", // Hide character counter
                          contentPadding: EdgeInsets.zero,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 2,
                            ),
                          ),
                        ),
                        onChanged: (value) => _onFieldChanged(value, index),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _verifyCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Verifikasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Tidak menerima kode verifikasi? ',
                    style: AppTextStyles.bodyStyle(
                      context,
                    ).copyWith(color: Colors.black),
                    children: [
                      TextSpan(
                        text: isResendEnabled
                            ? 'Kirim Ulang'
                            : 'Kirim Ulang dalam $timerText',
                        style: AppTextStyles.bodyStyle(context).copyWith(
                          color: isResendEnabled
                              ? AppColors.primary
                              : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: isResendEnabled
                            ? (TapGestureRecognizer()
                                ..onTap = () async {
                                  LoadingDialog.show(
                                    context,
                                    message: 'Mengirim ulang OTP...',
                                  );

                                  try {
                                    final provider = context
                                        .read<ForgotPasswordProvider>();
                                    await provider.sendOtp(widget.email);

                                    if (!mounted) return;

                                    LoadingDialog.hide(context);

                                    if (provider.state ==
                                        ForgotPasswordState.success) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Kode OTP berhasil dikirim ulang!',
                                          ),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      startTimer();
                                    } else {
                                      ErrorDialog.show(
                                        context,
                                        title: 'Gagal Mengirim OTP',
                                        message:
                                            provider.errorMessage ??
                                            'Gagal mengirim ulang kode OTP. Silakan coba lagi.',
                                      );
                                    }
                                  } catch (e) {
                                    if (!mounted) return;
                                    LoadingDialog.hide(context);
                                    ErrorDialog.show(
                                      context,
                                      title: 'Terjadi Kesalahan',
                                      message:
                                          'Terjadi kesalahan yang tidak terduga. Silakan coba lagi.',
                                    );
                                  }
                                })
                            : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
