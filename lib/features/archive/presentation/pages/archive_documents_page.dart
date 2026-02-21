import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_document_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveDocumentsPage extends StatelessWidget {
  const ArchiveDocumentsPage({
    super.key,
    required this.title,
    required this.options,
  });

  final String title;
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    final monthName = DateFormat("MMMM").format(DateTime(2026, options.month!));

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dokumen Karyawan",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${options.year} - $monthName",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            // Tampilkan kalo kosong
            // _EmptyDokumenView(tipeDokumen: options.tipeDokumen!),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final createdAt = DateTime(2025, 4, 15);
                final dateString = DateFormat(
                  "dd MMMM yyyy",
                ).format(createdAt);
                return ArchiveDocumentItem(dateString: dateString);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.black12,
                  height: 32,
                  thickness: 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyDokumenView extends StatelessWidget {
  const _EmptyDokumenView({required this.tipeDokumen});
  final String tipeDokumen;

  @override
  Widget build(BuildContext context) {
    final tipeDokumenLower = tipeDokumen.toLowerCase();

    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          "assets/images/icon/data_aproval_kosong.svg",
          height: 175,
        ),
        const SizedBox(height: 20),
        Text(
          "Anda belum memiliki arsip $tipeDokumenLower!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          "Jangan lupa untuk selalu melihat arsip $tipeDokumenLower Anda melalui aplikasi Maha!",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
