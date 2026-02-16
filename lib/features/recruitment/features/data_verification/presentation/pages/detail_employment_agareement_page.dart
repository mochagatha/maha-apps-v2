import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';

class DetailEmploymentAgareementPage extends StatelessWidget {
  const DetailEmploymentAgareementPage({super.key, required this.status});
  final int status;

  void _showRevision(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _RevisionBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        title: "Rincian Perjanjian Kerja",
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),

            //-----------/ Rincian /-----------//
            _DetailSection(
              children: [
                _buildDetail(
                  label: "No. Perjanjian",
                  value: "001.1 825/AGTA/JKTA/MAHA",
                ),
                _buildDetail(
                  label: "Waktu Perjanjian",
                  value: "1 Agustus 2024",
                ),
                _buildDetail(
                  label: "Tingkatan Pekerjaan",
                  value: "Staff",
                ),
                _buildDetail(
                  label: "Nama Jabatan",
                  value: "Backend",
                ),
                _buildDetail(
                  label: "Departemen",
                  value: "IT Departemen",
                ),
                _buildDetail(
                  label: "Atasan Langsung",
                  value: "Manager",
                ),
                _buildDetail(
                  label: "Status",
                  value: "Karyawan Tetap",
                ),
              ],
            ),

            //-----------/ Lampiran /-----------//
            SizedBox(height: 12),
            _DetailSection(
              children: [
                Text(
                  "Lampiran",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                _buildAttachment(
                  filename: "Perjanjian Kerja.pdf",
                  size: 5,
                  date: DateTime(2024, 8, 23),
                ),
              ],
            ),

            //-----------/ Pelacakan /-----------//
            SizedBox(height: 12),
            _DetailSection(
              children: [
                Text(
                  "Pelacakan",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _buildTracking(
                  context,
                  title: "Direvisi Direktur",
                  status: 2,
                  statusText: "Direvisi",
                  date: DateTime(2024, 8, 23, 13, 10),
                  isFirst: true,
                ),
                _buildTracking(
                  context,
                  title: "Diperiksa Manager HRD",
                  status: 0,
                  statusText: "Diperiksa",
                  date: DateTime(2024, 8, 23, 13, 10),
                ),
                _buildTracking(
                  context,
                  title: "Calon Karyawan",
                  status: 1,
                  statusText: "Disetujui",
                  date: DateTime(2024, 8, 23, 13, 10),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(12),
        child: _buildActions(),
      ),
    );
  }

  Widget? _buildActions() {
    if (status <= 1) {
      return Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              onPressed: () {},
              child: Text("Revisi"),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: CustomElevatedButton(
              onPressed: () {},
              child: Text("Setuju"),
            ),
          ),
        ],
      );
    }

    if (status == 3) {
      return CustomElevatedButton(
        onPressed: () {},
        child: Text("Revisi"),
      );
    }

    return null;
  }

  Widget _buildDetail({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 12),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachment({
    required String filename,
    required int size,
    required DateTime date,
  }) {
    final dateString = DateFormat("dd/MM/yyyy").format(date);
    return Row(
      children: [
        SizedBox(width: 12),
        Image.asset("assets/images/icon/pdf_icon.png"),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              filename,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "$size MB • di upload $dateString",
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTracking(
    BuildContext context, {
    required String title,
    required int status,
    required String statusText,
    required DateTime date,
    bool isFirst = false,
  }) {
    final backgroundColors = [
      Colors.yellow,
      Colors.greenAccent.shade700,
      Colors.red,
    ];
    final foregroundColors = [
      Colors.black,
      Colors.white,
      Colors.white,
    ];
    final dateString = DateFormat("dd MMMM hh:mm").format(date);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isFirst)
          SizedBox(
            height: 48,
            width: 48,
            child: VerticalDivider(
              color: backgroundColors[status],
              indent: 8,
              endIndent: 8,
              thickness: 2,
            ),
          ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: backgroundColors[status].withAlpha(60),
              ),
              child: Icon(
                Icons.check_circle,
                color: backgroundColors[status],
                size: 20,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  status == 2
                      ? GestureDetector(
                          onTap: () => _showRevision(context),
                          child: Text(
                            "Lihat disini",
                            style: TextStyle(
                              color: AppColors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 12,
                            ),
                          ),
                        )
                      : Text("-"),
                  SizedBox(height: 4),
                  Text(
                    "$dateString WIB",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: backgroundColors[status],
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  color: foregroundColors[status],
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DetailSection extends StatelessWidget {
  const _DetailSection({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class _RevisionBottomSheet extends StatelessWidget {
  const _RevisionBottomSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12),
        ),
        color: Colors.white,
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              SvgPicture.asset(
                "assets/images/icon/Frame 52086.svg",
                width: MediaQuery.of(context).size.width,
              ),
              Container(
                width: 128,
                height: 4,
                margin: EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ],
          ),
          Card(
            margin: EdgeInsets.all(20),
            elevation: 4,
            shadowColor: Colors.black54,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    "Alasan Direvisi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Apakah jam kerja bisa hari senin sampai jumat?",
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    onPressed: () => context.pop(),
                    child: Text("Tutup"),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {},
                    child: Text("Revisi"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
