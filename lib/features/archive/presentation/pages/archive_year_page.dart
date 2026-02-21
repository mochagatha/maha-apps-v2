import 'package:flutter/material.dart';
import 'package:maha_apps_v2/features/archive/domain/entities/archive_options.dart';
import 'package:maha_apps_v2/features/archive/presentation/pages/archive_month_page.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class ArchiveYearPage extends StatelessWidget {
  const ArchiveYearPage({super.key, required this.options});
  final ArchiveOptions options;

  @override
  Widget build(BuildContext context) {
    final years = [
      2021,
      2022,
      2023,
      2024,
      2025,
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: "Arsip ${options.title}",
      ),
      body: ListView.builder(
        itemCount: years.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, index) {
          final year = years[index];
          return ArchiveMenuItem(
            onTap: () {
              options.year = year;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ArchiveMonthPage(options: options),
                ),
              );
            },
            title: year.toString(),
            badgeCount: 0,
          );
        },
      ),
    );
  }
}
