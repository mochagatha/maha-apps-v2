import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
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

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: const FaIcon(FontAwesomeIcons.circleChevronLeft, color: Colors.white, size: 24),
          ),
        ),
        title: const Text(
          'Reset Kata Sandi',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
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
                  style: AppTextStyles.headingTwoSemiBold(context).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Kode verifikasi telah dikirim melalui e-mail ke ',
                    style: AppTextStyles.bodyStyle(context).copyWith(color: Colors.black),
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
                OtpTextField(
                  enabledBorderColor: Colors.grey,
                  focusedBorderColor: AppColors.primary,
                  numberOfFields: 4,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) async {
                    _showLoadingDialog(context);
                     final provider = context.read<ForgotPasswordProvider>();
                     await provider.verifyOtp(widget.email, verificationCode);
                     
                     if (context.mounted) {
                       Navigator.pop(context); // Close loading dialog
                       if (provider.state == ForgotPasswordState.success) {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => const ResetPasswordPage())
                          );
                       } else if (provider.state == ForgotPasswordState.error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(provider.errorMessage ?? 'Kode OTP Tidak Sesuai')),
                          );
                       }
                     }
                  },
                ),
                const SizedBox(height: 20),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Tidak menerima kode verifikasi? ',
                    style: AppTextStyles.bodyStyle(context).copyWith(color: Colors.black),
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
                                await context.read<ForgotPasswordProvider>().sendOtp(widget.email);
                                 if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('OTP sent successfully!')),
                                    );
                                 }
                                startTimer();
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
                Text(
                  'Sedang memverifikasi OTP...',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
