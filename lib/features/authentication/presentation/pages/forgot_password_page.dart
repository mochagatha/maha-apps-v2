import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../providers/forgot_password_provider.dart';

class InputEmailForgetPasswordPage extends StatefulWidget {
  const InputEmailForgetPasswordPage({super.key});

  @override
  State<InputEmailForgetPasswordPage> createState() => _InputEmailForgetPasswordPageState();
}

class _InputEmailForgetPasswordPageState extends State<InputEmailForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ForgotPasswordProvider>().resetState();
    });
    _emailController.addListener(() {
      context.read<ForgotPasswordProvider>().validateEmail(_emailController.text);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: SvgPicture.asset(
                    "assets/images/icon/forgot_password.svg",
                    height: 250, // Added height for better control
                  ),
                ),
              ),
              Text(
                'Reset Kata Sandi Anda',
                style: AppTextStyles.headingTwoSemiBold(context).copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8),
              Text(
                'Masukkan E-mail yang pernah terdaftar untuk melanjutkan reset password',
                style: AppTextStyles.bodyStyle(context).copyWith(color: Colors.black),
              ),
              const SizedBox(height: 20),
              Text(
                'Email',
                style: AppTextStyles.headingTwoSemiBold(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'contoh : ulil.ambri@mahasejahtera.com',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                   focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: Padding(
          // Added padding for better layout
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Consumer<ForgotPasswordProvider>(
            builder: (context, provider, child) {
              if (provider.state == ForgotPasswordState.loading) {
                return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.primary, width: 1.0),
                    ),
                  ),
                  child: const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                );
              }

              return ElevatedButton(
                onPressed: provider.isButtonEnabled
                    ? () async {
                        await provider.sendOtp(_emailController.text);
                        if (context.mounted) {
                          if (provider.state == ForgotPasswordState.success) {
                            // Navigate to OTP Verification (Not implemented yet)
                            ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text('OTP sent successfully!')));
                          } else if (provider.state == ForgotPasswordState.error) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Error'),
                                content: Text(provider.errorMessage ?? 'Unknown error'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: provider.isButtonEnabled 
                      ? AppColors.primary 
                      : Colors.grey, // Grey when disabled
                  disabledBackgroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 12.0), // Increased padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: provider.isButtonEnabled ? AppColors.primary : Colors.grey, 
                      width: 1.0
                    ),
                  ),
                ),
                child: const Text(
                  'Lanjut',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
