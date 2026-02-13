import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/statement_letters_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class StatementLetterPage extends StatelessWidget {
  const StatementLetterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Surat Pernyataan"),
      body: SfPdfViewer.network("http://192.168.100.130/tes.pdf"),
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
    final provider = context.read<StatementLettersProvider>();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);

    setState(() => _loading = true);
    final error = await provider.submitStatementLetter();
    setState(() => _loading = false);

    if (error != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.grey.shade700,
        ),
      );
    } else {
      router.pushReplacementNamed(AppRoutes.biodataStatementLetterSignature.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomElevatedButton(
        onPressed: _submit,
        loading: _loading,
        child: Text("Setuju"),
      ),
    );
  }
}
