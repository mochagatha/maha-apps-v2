import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';

class CreateEmploymentAgreementPage extends StatefulWidget {
  const CreateEmploymentAgreementPage({super.key});

  @override
  State<CreateEmploymentAgreementPage> createState() =>
      _CreateEmploymentAgreementPageState();
}

class _CreateEmploymentAgreementPageState
    extends State<CreateEmploymentAgreementPage> {
  late Future<void> _future;
  QuillController? _quillController;

  Future<void> _fetch() async {
    final url = "http://192.168.100.130/quill/pkwt.json";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception("Gagal mengambil template");
    }

    final data = jsonDecode(response.body);
    final delta = Delta.fromJson(data);
    final doc = Document.fromDelta(delta);

    _quillController = QuillController(
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }

  @override
  void initState() {
    super.initState();
    _future = _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Surat Perjanjian Kerja"),
      backgroundColor: Colors.grey[200],
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        minimumSize: Size(0, 0),
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        child: Text("Simpan"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: QuillEditor.basic(
                      controller: _quillController!,
                      config: QuillEditorConfig(
                        padding: EdgeInsets.zero,
                        unknownEmbedBuilder: QuillEditorImageEmbedBuilder(
                          config: QuillEditorImageEmbedConfig(),
                        ),
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
                ),
                SizedBox(height: 12),
                QuillSimpleToolbar(
                  controller: _quillController!,
                  config: QuillSimpleToolbarConfig(
                    multiRowsDisplay: false,
                    showAlignmentButtons: true,
                    embedButtons: FlutterQuillEmbeds.toolbarButtons(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
