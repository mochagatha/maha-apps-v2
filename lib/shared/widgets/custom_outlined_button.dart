import 'package:flutter/material.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color = AppColors.primary,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  final bool enabled;

  static Widget add({required VoidCallback onPressed, required Widget child}) {
    return _AddCustomOutlinedButton(
      onPressed: onPressed,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: enabled ? color : Colors.transparent,
          width: enabled ? 1 : 0,
        ),
        backgroundColor: enabled ? null : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          color: enabled ? color : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        child: child,
      ),
    );
  }
}

class _AddCustomOutlinedButton extends StatelessWidget {
  const _AddCustomOutlinedButton({
    required this.onPressed,
    required this.child,
  });

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8),
        ),
      ),
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 14,
          color: AppColors.blue,
          fontWeight: FontWeight.bold,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColors.blue),
              ),
              child: Icon(
                Icons.add,
                color: AppColors.blue,
                size: 14,
              ),
            ),
            SizedBox(width: 8),
            child,
          ],
        ),
      ),
    );
  }
}
