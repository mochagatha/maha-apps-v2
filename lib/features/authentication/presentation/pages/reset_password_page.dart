import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../../../shared/widgets/error_dialog.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/forgot_password_provider.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isButtonEnabled = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validateInput);
    _confirmPasswordController.addListener(_validateInput);

    // Validate that verification data exists
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ForgotPasswordProvider>();
      print('🔍 Reset Password Page: Checking verification data');

      if (provider.verificationData == null) {
        print('❌ Reset Password Page: No verification data found');
        ErrorDialog.show(
          context,
          title: 'Data Verifikasi Tidak Ditemukan',
          message: 'Silakan lakukan verifikasi OTP terlebih dahulu.',
        );
        // Navigate back after showing error
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) {
            context.go('/forgot-password');
          }
        });
      } else {
        print('✅ Reset Password Page: Verification data exists');
        print('  Employee ID: ${provider.verificationData!.employeeId}');
      }
    });
  }

  void _validateInput() {
    setState(() {
      _isButtonEnabled =
          _newPasswordController.text.length >= 6 &&
          _confirmPasswordController.text.length >= 6 &&
          _newPasswordController.text == _confirmPasswordController.text;
    });
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Ubah Kata Sandi',
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // v1 doesn't seem to have the big illustration here, but the design image might.
                // Assuming simple form like v1 screenshot or design.
                Text(
                  'Ubah Kata Sandi Anda',
                  style: AppTextStyles.headingTwoSemiBold(
                    context,
                  ).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  'Silahkan ubah kata sandi lama Anda untuk keamanan Akun',
                  style: AppTextStyles.bodyStyle(
                    context,
                  ).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),

                _buildTextField(
                  controller: _newPasswordController,
                  label: 'Masukkan Kata Sandi Baru',
                  hint: '******',
                  isPasswordVisible: _isNewPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isNewPasswordVisible = !_isNewPasswordVisible;
                    });
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: 'Konfirmasi Kata Sandi Baru',
                  hint: '******',
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onToggleVisibility: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 80,
        elevation: 0,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isButtonEnabled
                ? () async {
                    print('🔘 Reset Password Button: Clicked');

                    LoadingDialog.show(
                      context,
                      message: 'Mengubah kata sandi...',
                    );

                    try {
                      final provider = context.read<ForgotPasswordProvider>();

                      print(
                        '🔘 Reset Password Button: Calling provider.resetPassword',
                      );
                      await provider.resetPassword(
                        _newPasswordController.text,
                        _confirmPasswordController.text,
                      );

                      if (!mounted) return;

                      LoadingDialog.hide(context); // Close loading dialog

                      if (provider.state == ForgotPasswordState.success) {
                        print('✅ Reset Password Button: Success');
                        SuccessDialog.show(
                          context,
                          title: 'Berhasil',
                          message: 'Kata sandi Anda telah berhasil diubah!',
                          onConfirm: () {
                            context.go('/login');
                            provider.resetState();
                          },
                        );
                      } else if (provider.state == ForgotPasswordState.error) {
                        print(
                          '❌ Reset Password Button: Error - ${provider.errorMessage}',
                        );
                        ErrorDialog.show(
                          context,
                          title: 'Gagal Mengubah Kata Sandi',
                          message:
                              provider.errorMessage ??
                              'Gagal mengubah kata sandi. Silakan coba lagi.',
                        );
                      }
                    } catch (e) {
                      print('❌ Reset Password Button: Exception caught - $e');
                      if (!mounted) return;
                      LoadingDialog.hide(context);
                      ErrorDialog.show(
                        context,
                        title: 'Terjadi Kesalahan',
                        message:
                            'Terjadi kesalahan yang tidak terduga: ${e.toString()}',
                      );
                    }
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isButtonEnabled
                  ? Colors.red
                  : Colors.grey.shade300,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Simpan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool isPasswordVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            suffixIcon: IconButton(
              icon: FaIcon(
                isPasswordVisible
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash,
                size: 20,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            ),
          ),
        ),
      ],
    );
  }
}
