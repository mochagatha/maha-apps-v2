import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/shared/theme/app_theme.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_tab_bar.dart';

class EmployeeEMatraiPage extends StatelessWidget {
  const EmployeeEMatraiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final statusList = [
      "Baru",
      "Upload",
      "Selesai",
    ];

    return DefaultTabController(
      length: statusList.length,
      child: Scaffold(
        appBar: CustomAppBar(title: "Upload E-Matrai"),
        body: Column(
          children: [
            CustomTabBar(
              statusList: statusList,
              showAll: false,
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(statusList.length, (status) {
                  return ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      final statusText = statusList[status];
                      return _DataItem(
                        id: 1,
                        photoUrl: "",
                        name: "Akun Demo IT",
                        nik: 12345,
                        department: "IT Programming",
                        jobTitle: "Information Technology",
                        status: status,
                        statusText: statusText,
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataItem extends StatefulWidget {
  const _DataItem({
    required this.id,
    required this.photoUrl,
    required this.name,
    required this.nik,
    required this.department,
    required this.jobTitle,
    required this.status,
    required this.statusText,
  });

  final int id;
  final String photoUrl;
  final String name;
  final int nik;
  final String department;
  final String jobTitle;
  final int status;
  final String statusText;

  @override
  State<_DataItem> createState() => _DataItemState();
}

class _DataItemState extends State<_DataItem> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    final backgroundColors = [
      Colors.blue.withAlpha(40),
      Color(0xFFFFF5CD),
      Color(0xFFFFF5CD),
    ];
    final foregroundColors = [
      AppColors.blue,
      Color(0xFFBE9621),
      Color(0xFFBE9621),
    ];

    return Card(
      elevation: 2,
      margin: EdgeInsets.only(bottom: 8),
      shadowColor: Colors.black38,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: backgroundColors[widget.status],
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  widget.statusText,
                  style: TextStyle(
                    color: foregroundColors[widget.status],
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Akun Demo IT",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_id_card.svg",
                                  label: widget.nik.toString(),
                                ),
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_outline-phone.svg",
                                  label: "Verifikasi Data",
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_building.svg",
                                  label: widget.department,
                                ),
                                _buildMeta(
                                  assetIcon:
                                      "assets/images/icon/ic_building.svg",
                                  label: widget.jobTitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _buildAttachment(
              title: "Surat Perjanjian Kerja",
              size: 5,
              date: DateTime(2025, 4, 15),
              downloadUrl: "",
            ),
            if (widget.status < 2 && _selectedFile == null) ...[
              SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => setState(() => _selectedFile = File("")),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.blue),
                  foregroundColor: AppColors.blue,
                  backgroundColor: AppColors.blue.withAlpha(20),
                  padding: EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/icon/ic_file.svg",
                      height: 20,
                      width: 20,
                      colorFilter: ColorFilter.mode(
                        AppColors.blue,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Upload Surat Perjanjian Kerja (e-matrai)",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],

            if (_selectedFile != null) ...[
              _buildAttachment(
                title: "Surat Perjanjian Kerja (E-Matrai)",
                size: 5,
                date: DateTime(2025, 4, 15),
                selectedFile: _selectedFile,
              ),
              SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: CustomElevatedButton(
                  onPressed: () {},
                  child: Text("Selesai"),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMeta({required String assetIcon, required String label}) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: [
          SvgPicture.asset(
            assetIcon,
            height: 20,
            width: 20,
          ),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachment({
    required String title,
    required int size,
    required DateTime date,
    String? downloadUrl,
    File? selectedFile,
  }) {
    final dateString = DateFormat("dd MMMM yyyy").format(date);
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/images/icon/logo_pdf.svg",
            height: 36,
            width: 36,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  "$size MB • Diunggah $dateString",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          if (widget.status < 2 && downloadUrl != null)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                minimumSize: Size(0, 0),
              ),
              child: DefaultTextStyle(
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                child: Text(
                  "Unduh",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
          if (selectedFile != null)
            IconButton(
              onPressed: () => setState(() => _selectedFile = null),
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.all(6),
                minimumSize: Size(0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(8),
                ),
              ),
              icon: Icon(
                Icons.delete,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
