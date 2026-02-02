import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Extension to easily access AppLocalizations from BuildContext
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
