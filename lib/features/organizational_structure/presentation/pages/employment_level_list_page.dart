import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/menu_item_card.dart';

class EmploymentLevelListPage extends StatelessWidget {
  const EmploymentLevelListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'title': 'Karyawan',
        'icon': 'assets/images/icon/icon_karyawan.svg',
        'route': RoutePaths.employmentLevelEmployeeDetail,
      },
      {
        'title': 'Pekerja Harian',
        'icon': 'assets/images/icon/icon_pekerja.svg',
        'route': RoutePaths.employmentLevelWorkerDetail,
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Data Tingkatan Pekerja',
      ),
      body: RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          // Refresh logic if needed
        },
        child: ListView.builder(
          itemCount: menuItems.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return MenuItemCard(
              asset: item['icon'] as String,
              title: item['title'] as String,
              onTap: () {
                context.push(item['route'] as String);
              },
            );
          },
        ),
      ),
    );
  }
}
