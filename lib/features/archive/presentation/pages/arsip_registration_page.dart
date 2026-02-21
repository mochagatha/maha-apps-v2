import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArsipRegistrationPage extends StatelessWidget {
  const ArsipRegistrationPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Arsip Registrasi"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.syaratDanKetentuan;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Arsip Syarat dan Ketentuan",
                    "options": options,
                  },
                );
              },
              title: "Syarat dan Ketentuan",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/syarat_dan_ketentuan.svg",
            ),
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.privacyPolicy;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Arsip Kebijakan Privasi",
                    "options": options,
                  },
                );
              },
              title: "Kebijakan Privasi",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/kebijakan_privasi.svg",
            ),
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.peraturanPerusahaan;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Arsip Peraturan Perusahaan",
                    "options": options,
                  },
                );
              },
              title: "Peraturan Perusahaan",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/peraturan_perusahaan.svg",
            ),
          ],
        ),
      ),
    );
  }
}
