import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.title,
    required this.assetImage,
    required this.content,
    required this.action,
  });

  final String title;
  final String assetImage;
  final InlineSpan content;
  final Widget action;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            Image.asset(
              assetImage,
              height: 150,
            ),
            SizedBox(height: 24),
            Text.rich(
              content,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            action,
          ],
        ),
      ),
    );
  }
}
