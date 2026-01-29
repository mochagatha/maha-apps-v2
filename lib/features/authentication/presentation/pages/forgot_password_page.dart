import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/theme/app_text_styles.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/forgot_password_provider.dart';
import '../widgets/select_method_verification_dialog.dart';
import '../../../../core/utils/localization_extension.dart';

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
      appBar: CustomAppBar(title: context.l10n.resetYourPassword),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  context.l10n.resetYourPassword,
                  style: AppTextStyles.headingTwoSemiBold(context).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text(
                  context.l10n.enterEmailToResetPassword,
                  style: AppTextStyles.bodyStyle(context).copyWith(color: Colors.black),
                ),
                const SizedBox(height: 20),
                Text(
                  'Email',
                  style: AppTextStyles.headingTwoSemiBold(
                    context,
                  ).copyWith(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: context.l10n.emailHintExample,
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
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: Consumer<ForgotPasswordProvider>(
          builder: (context, provider, child) {
            // Removed loading state check here because loading now happens in the dialog/subsequent pages
            // OR keeping it if we want to blocking load on this page?
            // The design shows dialog for loading. So we don't need to block this button with loading content necessarily.
            // But let's keep it simple and just show the button always enabled if valid.

            return ElevatedButton(
              onPressed: provider.isButtonEnabled
                  ? () async {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) =>
                            SelectMethodVerificationDialog(email: _emailController.text),
                      );
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
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                context.l10n.next,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
