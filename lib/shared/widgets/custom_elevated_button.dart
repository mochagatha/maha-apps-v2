import 'package:flutter/material.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.loading = false,
    this.color = AppColors.primary,
  });

  final VoidCallback onPressed;
  final bool loading;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
