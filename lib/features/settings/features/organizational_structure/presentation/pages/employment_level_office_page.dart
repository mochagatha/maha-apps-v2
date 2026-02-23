import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/menu_item_card.dart';

class EmploymentLevelOfficePage extends StatelessWidget {
  const EmploymentLevelOfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = _buildMenuItems(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Data Tingkatan Pekerja'),
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
              title: item['text'] as String,
              onTap: item['action'] as VoidCallback,
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildMenuItems(BuildContext context) {
    return [
      {
        'icon': 'assets/images/icon/jam_kerja.svg',
        'text': 'Karyawan',
        'action': () {
          context.push(AppRoutes.employmentLevelOfficeEmployee.path);
        },
      },
      {
        'icon': 'assets/images/icon/pengaturan_lembur.svg',
        'text': 'Pekerja Harian',
        'action': () {
          context.push(AppRoutes.employmentLevelOfficeWorker.path);
        },
      },
    ];
  }
}
