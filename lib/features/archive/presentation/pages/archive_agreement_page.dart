import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveAgreementPage extends StatelessWidget {
  const ArchiveAgreementPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Arsip Perjanjian"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ArchiveMenuItem(
              onTap: () {
                options.tipeDokumen =
                    AppConstants.menu.subArsip.tipeDokumen.perjanjianKerja;
                context.push(
                  AppRoutes.archiveDocumentsMenu.path,
                  extra: {
                    "title": "Perjanjian Kerja",
                    "options": options,
                  },
                );
              },
              title: "Perjanjian Kerja",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/pernjanjian_kerja.svg",
            ),
          ],
        ),
      ),
    );
  }
}
