import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';
import 'package:provider/provider.dart';

import '../provider/employee_overtime_settings_provider.dart';
import '../widget/percentage_slider.dart';
import '../widget/switch_option.dart';

class EmployeeOvertimeSettingsPage extends StatelessWidget {
  const EmployeeOvertimeSettingsPage({super.key});

  void _submit(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          title: "Maaf Sebelumnya...",
          assetImage: "assets/images/icon/submit-biodata.png",
          content: TextSpan(
            children: [
              TextSpan(text: "Apakah Anda yakin ingin menyimpan "),
              TextSpan(
                text: "Pengaturan Lembur",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(text: " ini?"),
            ],
          ),
          action: Row(
            children: [
              Expanded(
                child: CustomOutlinedButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("Oke"),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: CustomElevatedButton(
                  onPressed: () => context.pop(),
                  child: Text("Batal"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<EmployeeOvertimeSettingsProvider>();

    return Scaffold(
      appBar: CustomAppBar(title: "Pengaturan Lembur"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _CustomLabel("Pengaturan Lembur Keseluruhan (Karyawan)"),
            SizedBox(height: 32),
            SwitchOption(
              label: "Pembukaan lembur karyawan",
              description: "Tanpa batasan waktu dan biaya",
            ),
            SizedBox(height: 12),
            SwitchOption(
              label: "Pembatasan lembur karyawan",
              description: "Ditentukan batas waktu atau biaya dalam presentase",
              onChanged: (value) => provider.showPercentage = value,
            ),
            Selector<EmployeeOvertimeSettingsProvider, bool>(
              selector: (_, provider) => provider.showPercentage,
              builder: (context, show, child) {
                if (!show) return SizedBox();
                return PercentageSlider();
              },
            ),
            SizedBox(height: 12),
            SwitchOption(
              label: "Penutupan lembur karyawan",
              description: "Tidak ada waktu dan biaya lembur",
            ),

            SizedBox(height: 48),
            _CustomLabel("Pengaturan Lembur Perorangan (Karyawan)"),
            SizedBox(height: 12),
            SizedBox(
              height: 40,
              child: TextField(
                controller: provider.searchController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Cari karyawan disini...",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 7,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.push(
                      AppRoutes.settingsAbsensiLemburKaryawanOrangan.path,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 16,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 20,
                        ),
                        SizedBox(width: 24),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Nama Karyawan",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Software Engineer",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: CustomElevatedButton(
          onPressed: () => _submit(context),
          child: Text("Simpan"),
        ),
      ),
    );
  }
}

class _CustomLabel extends StatelessWidget {
  const _CustomLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
