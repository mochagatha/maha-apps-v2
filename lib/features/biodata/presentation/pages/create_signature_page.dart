import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/route_names.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/signature_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class CreateSignaturePage extends StatefulWidget {
  const CreateSignaturePage({super.key});

  @override
  State<CreateSignaturePage> createState() => _CreateSignaturePageState();
}

class _CreateSignaturePageState extends State<CreateSignaturePage> {
  @override
  Widget build(BuildContext context) {
    final signatureProvider = context.read<SignatureProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: "Buat Tanda Tangan"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tanda Tangan",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              "Pastikan tanda tangan yang Anda buat sesuai dengan tanda tangan di KTP Anda.",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 12),
            Container(
              height: 250,
              width: double.infinity,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Signature(
                controller: signatureProvider.signatureController,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.info,
                  color: Colors.blue,
                  size: 15,
                ),
                Text(
                  "Tanda tangani pada ruang kosong di atas!",
                  style: TextStyle(color: Colors.blue, fontSize: 12),
                ),
              ],
            ),
            SizedBox(height: 18),
            ElevatedButton(
              onPressed: signatureProvider.signatureController.clear,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow.shade800,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    size: 22,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Hapus",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _SubmitButton(),
    );
  }
}

class _SubmitButton extends StatefulWidget {
  const _SubmitButton();

  @override
  State<_SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<_SubmitButton> {
  bool _loading = false;

  void _submit() async {
    final provider = context.read<SignatureProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    setState(() => _loading = true);
    final error = await provider.submit();
    setState(() => _loading = false);

    if (error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.grey.shade700,
        ),
      );
    } else {
      router.pushReplacementNamed(RouteNames.biodataStatementLetter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(12),
      child: CustomElevatedButton(
        onPressed: _submit,
        loading: _loading,
        child: Text("Lanjutkan"),
      ),
    );
  }
}
