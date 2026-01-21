import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';

class TermsAndConditionsSheet extends StatefulWidget {
  const TermsAndConditionsSheet({super.key});

  @override
  State<TermsAndConditionsSheet> createState() =>
      _TermsAndConditionsSheetState();
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
            Image.asset('assets/maha.png', height: 60),
            const SizedBox(height: 20),

            // Title
            Text(
              context.l10n.termsAndConditionsTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor:
                      Colors.grey[300], // Light gray for disabled state
                ),
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
