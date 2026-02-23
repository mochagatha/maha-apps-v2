import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';
import 'package:maha_apps_v2/shared/widgets/custom_dialog.dart';
import 'package:maha_apps_v2/shared/widgets/custom_elevated_button.dart';
import 'package:maha_apps_v2/shared/widgets/custom_outlined_button.dart';

import '../../../../presentation/widgets/employee_list_view.dart';
import '../../../../presentation/widgets/switch_option.dart';

class EmployeeAttendanceAnywherePage extends StatefulWidget {
  const EmployeeAttendanceAnywherePage({super.key});

  @override
  State<EmployeeAttendanceAnywherePage> createState() =>
      _EmployeeAttendanceAnywherePageState();
}

class _EmployeeAttendanceAnywherePageState
    extends State<EmployeeAttendanceAnywherePage> {
  final _searchController = TextEditingController();

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
                text: "Akses Absen Dimana Saja",
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
    return Scaffold(
      appBar: CustomAppBar(title: "Pengaturan Akses Absen Dimana Saja"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _CustomLabel("Pengaturan Akses Absen Dimana Saja (Karyawan)"),
            SizedBox(height: 24),
            SwitchOption(
              label: "Perizinan Absen Dimana Saja",
              description: "Izin untuk absen dimana saja bagi karyawan",
            ),
            SizedBox(height: 24),
            _CustomLabel(
              "Pengaturan Akses Absen Dimana Saja Perorangan (Karyawan)",
            ),
            SizedBox(height: 12),
            EmployeeListView(
              searchController: _searchController,
              onItemTap: () {
                context.push(
                  AppRoutes.settingsAbsensiAbsenDimanaSajaKaryawanOrangan.path,
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
