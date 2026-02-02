import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/document_provider.dart';
import '../widgets/upload_document.dart'; // Using our new widget

class DocumentPage extends StatelessWidget {
  const DocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Formulir Data Diri'),
      body: Consumer<DocumentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingData) {
            return const Center(child: SpinKitThreeBounce(color: AppColors.primary));
          }

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.only(top: 50, bottom: 90),
                child: Form(
                  key: provider.formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload Dokumen',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "Tambahkan dokumen yang diperlukan perusahaan, Contoh : Foto Pr, KTP, KK, Ijazah, dll.",
                          style: TextStyle(fontSize: 14, color: Color(0xff5F5F5F)),
                        ),
                        const SizedBox(height: 20),

                        // --- UPLOAD WIDGETS ---
                        UploadDocument(
                          title: 'Pas Photo',
                          text: 'File yang didukung : jpg, jpeg',
                          allowedFileTypes: const ['jpg', 'jpeg'],
                          isRequired: true,
                          fileSelected: provider.selectedFiles['photo'] != null,
                          initialFilePath: provider.selectedFiles['photo'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('photo', path),
                        ),

                        UploadDocument(
                          title: 'KTP',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequired: true,
                          fileSelected: provider.selectedFiles['ktp'] != null,
                          initialFilePath: provider.selectedFiles['ktp'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('ktp', path),
                        ),

                        UploadDocument(
                          title: 'Kartu Keluarga',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequired: true,
                          fileSelected: provider.selectedFiles['kk'] != null,
                          initialFilePath: provider.selectedFiles['kk'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('kk', path),
                        ),

                        UploadDocument(
                          title: 'Buku rekening',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequired: true,
                          fileSelected: provider.selectedFiles['rekening'] != null,
                          initialFilePath: provider.selectedFiles['rekening'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('rekening', path),
                        ),

                        UploadDocument(
                          title: 'Ijazah',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequired: true,
                          fileSelected: provider.selectedFiles['ijazah'] != null,
                          initialFilePath: provider.selectedFiles['ijazah'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('ijazah', path),
                        ),

                        UploadDocument(
                          title: 'Transkrip Nilai',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequiredOpsional: true,
                          fileSelected: provider.selectedFiles['transkrip'] != null,
                          initialFilePath: provider.selectedFiles['transkrip'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('transkrip', path),
                        ),

                        UploadDocument(
                          title: 'Sertifikat Keahlian',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequiredOpsional: true,
                          fileSelected: provider.selectedFiles['sertif_keahlian'] != null,
                          initialFilePath: provider.selectedFiles['sertif_keahlian'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('sertif_keahlian', path),
                        ),

                        UploadDocument(
                          title: 'NPWP',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequiredOpsional: true,
                          fileSelected: provider.selectedFiles['npwp'] != null,
                          initialFilePath: provider.selectedFiles['npwp'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('npwp', path),
                        ),

                        UploadDocument(
                          title: 'BPJS Ketenagakerjaan',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequiredOpsional: true,
                          fileSelected: provider.selectedFiles['bpjs_ketenagakerjaan'] != null,
                          initialFilePath: provider.selectedFiles['bpjs_ketenagakerjaan'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('bpjs_ketenagakerjaan', path),
                        ),

                        UploadDocument(
                          title: 'BPJS Kesehatan',
                          text: 'File yang didukung : pdf',
                          allowedFileTypes: const ['pdf'],
                          isRequiredOpsional: true,
                          fileSelected: provider.selectedFiles['bpjs_kesehatan'] != null,
                          initialFilePath: provider.selectedFiles['bpjs_kesehatan'],
                          labelText: 'Pilih dokumen yang di Upload',
                          onFileSelected: (path) => provider.setFile('bpjs_kesehatan', path),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              const HeaderScrollDocument(),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        elevation: 0,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  context.pop();
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: AppColors.primary),
                    SizedBox(width: 8),
                    Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final provider = context.read<DocumentProvider>();
                  final isValid = await provider.submit();

                  if (isValid && context.mounted) {
                    context.pushNamed(RouteNames.skillForm);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderScrollDocument extends StatelessWidget {
  const HeaderScrollDocument({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        color: Colors.white,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _checkContract(isActive: true, number: 1, title: "Biodata"),
                _checkContract(isActive: true, number: 2, title: "Riwayat Pendidikan"),
                _checkContract(isActive: true, number: 3, title: "Data Keluarga"),
                _checkContract(isActive: true, number: 4, title: "Kelengkapan Dokumen"),
                _checkContract(number: 5, title: "Keahlian"),
                _checkContract(number: 6, title: "Ambil Foto Selfie"),
                _checkContract(number: 7, title: "Ambil Foto Selfie dengan KTP"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _checkContract({required int number, required String title, bool isActive = false}) {
    return Row(
      children: [
        if (number != 1)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 40,
              height: 3,
              color: isActive ? const Color(0xffFDE0D1) : AppColors.secondary,
            ),
          ),
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.primary : Colors.white,
            border: Border.all(color: isActive ? AppColors.primary : AppColors.secondary),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.secondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? AppColors.primary : AppColors.secondary,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
