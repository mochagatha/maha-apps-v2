import 'package:flutter/material.dart';
import 'package:maha_apps_v2/widgets/colors.dart';

void showLoadingLoginDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.primaryColor),
            SizedBox(height: 20),
            Text('Sedang memuat...', style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    },
  );
}
