import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/providers/language_provider.dart';
import '../../../../core/utils/localization_extension.dart';

/// Reusable language selection widget
/// Shows a modal bottom sheet for language selection
class LanguageSelector {
  /// Show language selection dialog
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    context.l10n.selectLanguage,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Indonesian option
                  _LanguageOption(
                    title: context.l10n.languageIndonesian,
                    flag: '🇮🇩',
                    isSelected: languageProvider.currentLocale.languageCode == 'id',
                    onTap: () {
                      languageProvider.changeLanguage(const Locale('id'));
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),

                  // English option
                  _LanguageOption(
                    title: context.l10n.languageEnglish,
                    flag: '🇺🇸',
                    isSelected: languageProvider.currentLocale.languageCode == 'en',
                    onTap: () {
                      languageProvider.changeLanguage(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

/// Internal widget for language option
class _LanguageOption extends StatelessWidget {
  final String title;
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0F0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
