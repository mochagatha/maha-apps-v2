import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/employment_agreement_provider.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:http/http.dart' as http;
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:provider/provider.dart';

class EmployeeEmploymentAgreementPage extends StatefulWidget {
  const EmployeeEmploymentAgreementPage({super.key});

  @override
  State<EmployeeEmploymentAgreementPage> createState() =>
      _EmployeeEmploymentAgreementPageState();
}

class _EmployeeEmploymentAgreementPageState
    extends State<EmployeeEmploymentAgreementPage> {
  QuillController? _quillController;
  bool _loading = true;

  void _loadDocument() async {
    final url = "http://192.168.100.130/quill/pkwt";
    setState(() => _loading = true);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final delta = Delta.fromJson(data);
      final doc = Document.fromDelta(delta);
      _loading = false;
      setState(() {
        _quillController = QuillController(
          document: doc,
          selection: const TextSelection.collapsed(offset: 0),
          readOnly: true,
        );
      });
    } else {
      // TODO: handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDocument();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Surat Perjanjian Kerja"),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12),
              child: QuillEditor.basic(
                controller: _quillController!,
                config: QuillEditorConfig(
                  checkBoxReadOnly: true,
                  padding: EdgeInsets.zero,
                  unknownEmbedBuilder: QuillEditorImageEmbedBuilder(
                    config: QuillEditorImageEmbedConfig(),
                  ),
                  showCursor: false,
                  customStyles: DefaultStyles(
                    paragraph: DefaultTextBlockStyle(
                      const TextStyle(fontSize: 12, color: Colors.black),
                      HorizontalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                    lists: DefaultListBlockStyle(
                      const TextStyle(fontSize: 12, color: Colors.black),
                      HorizontalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                      null,
                    ),
                    indent: DefaultTextBlockStyle(
                      const TextStyle(fontSize: 12, color: Colors.black),
                      HorizontalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                    leading: DefaultTextBlockStyle(
                      const TextStyle(fontSize: 12, color: Colors.black),
                      HorizontalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      VerticalSpacing(0, 0),
                      null,
                    ),
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  side: BorderSide(color: AppColors.primary),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                  child: Text("Revisi"),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _SubmitButton(),
            ),
          ],
        ),
      ),
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
    final provider = context.read<EmploymentAgreementProvider>();
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
    } else if (mounted) {
      await showDialog(
        context: context,
        builder: (context) => _SetujuPopup(),
      );
      router.goNamed(AppRoutes.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: _submit,
      loading: _loading,
      child: Text("Setuju"),
    );
  }
}

class _SetujuPopup extends StatelessWidget {
  const _SetujuPopup();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Maaf Sebelumnya!",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            SizedBox(height: 8),
            Image.asset(
              "assets/images/icon/success-register.png",
              height: 170,
            ),
            SizedBox(height: 12),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Surat persetujuan Anda "),
                  TextSpan(
                    text: "Sedang dalam proses persetujuan.",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " Mohon untuk menunggu!"),
                ],
              ),
              style: TextStyle(color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
