import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';

class PinVerificationDialog extends StatefulWidget {
  const PinVerificationDialog({super.key});

  @override
  State<PinVerificationDialog> createState() => _PinVerificationDialogState();
}

class _PinVerificationDialogState extends State<PinVerificationDialog> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
    
    // Check if all fields are filled
    if (_controllers.every((controller) => controller.text.isNotEmpty)) {
      _verifyCode();
    }
  }

  void _onBackspace(int index) {
    if (index > 0 && _controllers[index].text.isEmpty) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyCode() async {
    final code = _controllers.map((c) => c.text).join();
    
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );

    // Simulate API call - In real implementation, call API to verify code
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    Navigator.pop(context); // Close loading

    // For now, accept any 6-digit code
    // TODO: Implement actual API verification
    if (code.length == 6) {
      Navigator.pop(context); // Close PIN dialog
      _showTermsAndConditions();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.pinInvalid),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  void _showTermsAndConditions() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const TermsAndConditionsSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.pinVerificationTitle,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.pinVerificationMessage,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 40,
                child: TextField(
                  controller: _controllers[index],
                  focusNode: _focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  obscureText: true,
                  decoration: InputDecoration(
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: AppColors.primary),
                    ),
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => _onDigitChanged(index, value),
                  onTap: () {
                    if (_controllers[index].text.isNotEmpty) {
                      _controllers[index].clear();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsAndConditionsSheet extends StatefulWidget {
  const TermsAndConditionsSheet({super.key});

  @override
  State<TermsAndConditionsSheet> createState() => _TermsAndConditionsSheetState();
}

class _TermsAndConditionsSheetState extends State<TermsAndConditionsSheet> {
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            // Handle bar
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 5,
                width: 70,
                decoration: BoxDecoration(
                  color: AppColors.neutral5,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            
            Divider(color: AppColors.neutral3, height: 1),
            const SizedBox(height: 20),

            // Logo
            Image.asset(
              'assets/maha.png',
              height: 60,
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              context.l10n.termsAndConditionsTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              context.l10n.termsAndConditionsMessage,
              style: const TextStyle(fontSize: 13),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),

            // Links
            Row(
              children: [
                const Icon(Icons.circle, size: 5),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to terms page
                  },
                  child: Text(
                    context.l10n.termsOfUse,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.circle, size: 5),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to privacy page
                  },
                  child: Text(
                    context.l10n.privacyNotice,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Agreement checkbox
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.neutral2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: _isAgreed,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _isAgreed = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      context.l10n.agreeTerms,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Agree button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isAgreed
                    ? () {
                        Navigator.pop(context);
                        context.go(RoutePaths.register);
                      }
                    : null,
                child: Text(context.l10n.iAgree),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
