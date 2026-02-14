import 'package:flutter/material.dart';
import 'package:maha_apps_v2/features/biodata/presentation/providers/biodata_revision_provider.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class RevisionFormPage extends StatefulWidget {
  const RevisionFormPage({super.key});

  @override
  State<RevisionFormPage> createState() => _RevisionFormPageState();
}

class _RevisionFormPageState extends State<RevisionFormPage> {
  late final BiodataRevisionProvider _revisionProvider;

  void _initialValues() {
    _revisionProvider.nameController.text = "Ulil Ambri";
    _revisionProvider.seniorSchoolNameController.text = "SMK Negeri 4";
    _revisionProvider.spouseController.text = "Siapa yaa";
  }

  void _submitRevision() {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Data Diri Berhasil Dikirim",
          assetImage: "assets/images/icon/verifikasi-data.png",
          content: TextSpan(
            children: [
              TextSpan(
                children: [
                  TextSpan(text: "Mohon untuk menunggu "),
                  TextSpan(
                    text: "Verifikasi Data Diri",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " Anda dari HRD Maha!"),
                ],
              ),
            ],
          ),
          action: CustomElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icon/whatsapp.png",
                  height: 16,
                  width: 16,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 8),
                const Text(
                  'Hubungi Admin',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _revisionProvider = context.read<BiodataRevisionProvider>();
    _initialValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Perbaikan Data Diri"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeading("Informasi Pribadi"),
            _buildField(
              controller: _revisionProvider.nameController,
              label: "Nama Lengkap",
              hint: "Masukkan nama lengkap...",
            ),
            _buildHeading("SMA/SMK/MAN"),
            _buildField(
              controller: _revisionProvider.seniorSchoolNameController,
              label: "Nama Sekolah",
              hint: "Masukkan nama sekolah...",
            ),
            _buildHeading("Istri"),
            _buildField(
              controller: _revisionProvider.spouseController,
              label: "Nama Lengkap",
              hint: "Masukkan nama lengkap...",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: _submitRevision,
          child: Text("Perbaiki"),
        ),
      ),
    );
  }

  Widget _buildHeading(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: label,
              ),
              TextSpan(
                text: " *",
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        CustomTextFormField(
          controller: controller,
          hintText: hint,
        ),
        SizedBox(height: 8),
        Text(
          "Data diri tidak sesuai",
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      ],
    );
  }
}
