import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveStatementPage extends StatelessWidget {
  const ArchiveStatementPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Arsip Pernyataan Karyawan"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.rekeningBank;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Rekening Bank",
                    "options": options,
                  },
                );
              },
              title: "Rekening Bank",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/rekening_bank.svg",
            ),
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.tandaTangan;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Tanda Tangan",
                    "options": options,
                  },
                );
              },
              title: "Tanda Tangan",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/tanda_tangan.svg",
            ),
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.pernyataan;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Pernyataan",
                    "options": options,
                  },
                );
              },
              title: "Pernyataan",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/pernyataan2.svg",
            ),
          ],
        ),
      ),
    );
  }
}
