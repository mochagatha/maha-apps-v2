import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class OvertimeSettingsPage extends StatelessWidget {
  const OvertimeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      SettingsMenuItem(
        iconPath: "assets/images/icon/karyawan_icon.svg",
        title: "Karyawan",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiLemburKaryawan.path,
          );
        },
      ),
      SettingsMenuItem(
        iconPath: "assets/images/icon/pekerja_harian_icon.svg",
        title: "Pekerja Harian",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiLemburPekerjaHarian.path,
          );
        },
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Pengaturan Lembur"),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: menus.length,
        itemBuilder: (context, index) => menus[index],
      ),
    );
  }
}
