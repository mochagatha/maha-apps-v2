import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? messageActionText;
  final Widget? child;
  final VoidCallback? onConfirm;
  final bool canPop;

  const SuccessDialog({
    super.key,
    this.title = 'Berhasil!',
    required this.message,
    this.messageActionText,
    this.child,
    this.onConfirm,
    this.canPop = true,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: canPop,
      child: AlertDialog(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        content: SizedBox(
          width: MediaQuery.of(context).size.width - 120,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/icon/done.png')),
                ),
              ),
              const SizedBox(height: 20),
              child ??
                  Text.rich(
                    TextSpan(
                      text: message,
                      style: const TextStyle(color: Colors.grey),
                      children: [
                        if (messageActionText != null)
                          TextSpan(
                            text: " $messageActionText",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        const TextSpan(
                          text: '!',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm?.call();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                  ),
                  child: const Text(
                    'Oke',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void show(
    BuildContext context, {
    String? title,
    required String message,
    String? messageActionText,
    Widget? child,
    VoidCallback? onConfirm,
    bool canPop = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SuccessDialog(
          title: title ?? 'Berhasil!',
          message: message,
          messageActionText: messageActionText,
          onConfirm: onConfirm,
          canPop: canPop,
          child: child,
        );
      },
    );
  }
}
