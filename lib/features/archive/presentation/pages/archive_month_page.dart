import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/pages/archive_work_status_page.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveMonthPage extends StatelessWidget {
  const ArchiveMonthPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Arsip ${options.title}",
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: 12,
        itemBuilder: (context, index) {
          final month = index + 1;
          final monthString = DateFormat("MMMM").format(DateTime(2026, month));
          options.month = month;
          return ArchiveMenuItem(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    if (options.typeRole == TypeRole.none) {
                      // TODO: handle none status
                    }
                    return ArchiveWorkStatusPage(options: options);
                  },
                ),
              );
            },
            title: monthString.toString(),
            badgeCount: 0,
          );
        },
      ),
    );
  }
}
