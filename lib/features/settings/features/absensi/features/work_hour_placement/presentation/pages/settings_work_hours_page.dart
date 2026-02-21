import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/settings/presentation/widgets/settings_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class SettingsWorkHoursPage extends StatelessWidget {
  const SettingsWorkHoursPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menus = [
      SettingsMenuItem(
        iconPath: "assets/images/icon/ic_jam_kerja_normal.svg",
        title: "Normal",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiDetailJamKerja.path,
            extra: {"name": "Normal"},
          );
        },
      ),
      SettingsMenuItem(
        iconPath: "assets/images/icon/ic_jam_kerja_proyek.svg",
        title: "Proyek",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiDetailJamKerja.path,
            extra: {"name": "Proyek"},
          );
        },
      ),
      SettingsMenuItem(
        iconPath: "assets/images/icon/ic_jam_kerja_shift1.svg",
        title: "Shift 1",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiDetailJamKerja.path,
            extra: {"name": "Shift 1"},
          );
        },
      ),
      SettingsMenuItem(
        iconPath: "assets/images/icon/ic_jam_kerja_shift2.svg",
        title: "Shift 2",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiDetailJamKerja.path,
            extra: {"name": "Shift 2"},
          );
        },
      ),
      SettingsMenuItem(
        iconPath: "assets/images/icon/ic_jam_kerja_khusus.svg",
        title: "Khusus",
        onTap: () {
          context.push(
            AppRoutes.settingsAbsensiDetailJamKerja.path,
            extra: {"name": "Khusus"},
          );
        },
      ),
    ];

    return Scaffold(
      appBar: CustomAppBar(title: "Jam Kerja"),
      body: ListView.builder(
        padding: const EdgeInsets.all(15),
        itemCount: menus.length,
        itemBuilder: (context, index) => menus[index],
      ),
    );
  }
}
