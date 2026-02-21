import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveWorkStatusPage extends StatelessWidget {
  const ArchiveWorkStatusPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Arsip ${options.title}",
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            ArchiveMenuItem(
              onTap: () {
                options.typeRole = TypeRole.employee;
                context.push(options.pagePath, extra: {"options": options});
              },
              title: "Karyawan",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/karyawan.svg",
            ),
            ArchiveMenuItem(
              onTap: () {
                options.typeRole = TypeRole.worker;
                context.push(options.pagePath, extra: {"options": options});
              },
              title: "Pekerja Harian",
              badgeCount: 0,
              iconPath: "assets/images/svg/arsip/pekerja_harian.svg",
            ),
          ],
        ),
      ),
    );
  }
}
