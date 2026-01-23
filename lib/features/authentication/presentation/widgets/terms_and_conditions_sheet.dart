import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';

/// Bottom sheet widget untuk menampilkan terms and conditions
/// sebelum user melakukan registrasi
class TermsAndConditionsSheet extends StatefulWidget {
  const TermsAndConditionsSheet({super.key});

  @override
  State<TermsAndConditionsSheet> createState() => _TermsAndConditionsSheetState();
}

class _TermsAndConditionsSheetState extends State<TermsAndConditionsSheet> {
  // Constants
  static const double _sheetHeightRatio = 0.75;
  static const double _horizontalPadding = 20.0;
  static const double _handleBarHeight = 5.0;
  static const double _handleBarWidth = 70.0;
  static const double _handleBarPadding = 15.0;
  static const double _handleBarRadius = 10.0;
  static const double _logoHeight = 60.0;
  static const double _titleFontSize = 18.0;
  static const double _descriptionFontSize = 13.0;
  static const double _linkFontSize = 14.0;
  static const double _agreeFontSize = 12.0;
  static const double _bulletIconSize = 5.0;
  static const double _checkboxContainerRadius = 10.0;
  static const double _checkboxContainerPadding = 12.0;
  static const double _spacingXSmall = 8.0;
  static const double _spacingSmall = 16.0;
  static const double _spacingMedium = 20.0;
  static const double _spacingLarge = 24.0;
  static const double _bottomSpacingSmall = 12.0;
  static const double _bottomSpacingLarge = 24.0;

  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height * _sheetHeightRatio,
      width: mediaQuery.size.width,
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(
            left: _horizontalPadding,
            right: _horizontalPadding,
            bottom: mediaQuery.viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandleBar(),
              Divider(color: AppColors.neutral3, height: 1),
              const SizedBox(height: _spacingMedium),
              _buildScrollableContent(context),
              _buildAgreementCheckbox(context),
              const SizedBox(height: _spacingSmall),
              _buildAgreeButton(context),
              SizedBox(
                height:
                    (mediaQuery.padding.bottom > 0 ? _bottomSpacingSmall : _bottomSpacingLarge) +
                    20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget untuk handle bar di atas sheet
  Widget _buildHandleBar() {
    return Padding(
      padding: const EdgeInsets.all(_handleBarPadding),
      child: Container(
        height: _handleBarHeight,
        width: _handleBarWidth,
        decoration: BoxDecoration(
          color: AppColors.neutral5,
          borderRadius: BorderRadius.circular(_handleBarRadius),
        ),
      ),
    );
  }

  /// Widget untuk konten yang dapat di-scroll
  Widget _buildScrollableContent(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildLogo(),
            const SizedBox(height: _spacingMedium),
            _buildTitle(context),
            const SizedBox(height: _spacingSmall),
            _buildDescription(context),
            const SizedBox(height: _spacingSmall),
            _buildLinkItem(
              context,
              text: context.l10n.termsOfUse,
              onTap: () => context.push(RoutePaths.termsAndConditions),
            ),
            const SizedBox(height: _spacingXSmall),
            _buildLinkItem(
              context,
              text: context.l10n.privacyNotice,
              onTap: () => context.push(RoutePaths.privacyNotice),
            ),
            const SizedBox(height: _spacingLarge),
          ],
        ),
      ),
    );
  }

  /// Widget untuk logo
  Widget _buildLogo() {
    return Image.asset('assets/maha.png', height: _logoHeight);
  }

  /// Widget untuk title
  Widget _buildTitle(BuildContext context) {
    return Text(
      context.l10n.termsAndConditionsTitle,
      style: const TextStyle(fontSize: _titleFontSize, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  /// Widget untuk description
  Widget _buildDescription(BuildContext context) {
    return Text(
      context.l10n.termsAndConditionsMessage,
      style: const TextStyle(fontSize: _descriptionFontSize),
      textAlign: TextAlign.start,
    );
  }

  /// Widget untuk item link dengan bullet point
  Widget _buildLinkItem(BuildContext context, {required String text, required VoidCallback onTap}) {
    return Row(
      children: [
        const Icon(Icons.circle, size: _bulletIconSize),
        const SizedBox(width: _spacingXSmall),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: _linkFontSize,
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  /// Widget untuk checkbox persetujuan
  Widget _buildAgreementCheckbox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_checkboxContainerPadding),
      decoration: BoxDecoration(
        color: AppColors.neutral2,
        borderRadius: BorderRadius.circular(_checkboxContainerRadius),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _isAgreed,
            activeColor: AppColors.primary,
            onChanged: _handleCheckboxChanged,
          ),
          Expanded(
            child: Text(context.l10n.agreeTerms, style: const TextStyle(fontSize: _agreeFontSize)),
          ),
        ],
      ),
    );
  }

  /// Widget untuk tombol setuju
  Widget _buildAgreeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isAgreed ? _handleAgreeButtonPressed : null,
        style: ElevatedButton.styleFrom(disabledBackgroundColor: Colors.grey[300]),
        child: Text(context.l10n.iAgree),
      ),
    );
  }

  /// Handler untuk perubahan checkbox
  void _handleCheckboxChanged(bool? value) {
    setState(() {
      _isAgreed = value ?? false;
    });
  }

  /// Handler untuk tombol setuju
  void _handleAgreeButtonPressed() {
    Navigator.pop(context);
    context.go(RoutePaths.register);
  }
}
