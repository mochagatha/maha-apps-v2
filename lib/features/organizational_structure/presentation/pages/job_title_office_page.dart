import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/menu_item_card.dart';

class JobTitleOfficePage extends StatelessWidget {
  const JobTitleOfficePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = _buildMenuItems(context);

    return Scaffold(
      appBar: const CustomAppBar(title: 'Data Jabatan'),
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
          context.push(RoutePaths.jobTitleOfficeEmployee);
        },
      },
      {
        'icon': 'assets/images/icon/pengaturan_lembur.svg',
        'text': 'Pekerja Harian',
        'action': () {
          context.push(RoutePaths.jobTitleOfficeWorker);
        },
      },
    ];
  }
}
