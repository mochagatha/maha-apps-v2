import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/menu_item_card.dart';

class OrganizationalStructureListPage extends StatelessWidget {
  const OrganizationalStructureListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = _buildMenuItems(context);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Struktur Organisasi',
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
            final bool isEnabled = item['enabled'] as bool;
            return Opacity(
              opacity: isEnabled ? 1.0 : 0.5,
              child: MenuItemCard(
                asset: item['icon'] as String,
                title: item['text'] as String,
                onTap: isEnabled ? item['action'] as VoidCallback : () {},
              ),
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildMenuItems(BuildContext context) {
    return [
      {
        'icon': 'assets/images/icon/penempatan_kerja_icon.svg',
        'text': 'Struktur Utama',
        'enabled': true,
        'action': () {
          context.push(RoutePaths.structureMain);
        },
      },
      {
        'icon': 'assets/images/icon/penempatan_kerja_icon.svg',
        'text': 'Struktur Proyek',
        'enabled': false,
        'action': null,
      },
      {
        'icon': 'assets/images/icon/penempatan_kerja_icon.svg',
        'text': 'Struktur Cabang',
        'enabled': false,
        'action': null,
      },
      {
        'icon': 'assets/images/icon/tingkatan.svg',
        'text': 'Data Tingkatan Pekerjaan',
        'enabled': true,
        'action': () {
          context.push(RoutePaths.employmentLevel);
        },
      },
      {
        'icon': 'assets/images/icon/departemen.svg',
        'text': 'Data Departemen',
        'enabled': true,
        'action': () {
          context.push(RoutePaths.departmentList);
        },
      },
      {
        'icon': 'assets/images/icon/jabatan.svg',
        'text': 'Data Jabatan',
        'enabled': true,
        'action': () {
          context.push(RoutePaths.jobTitleList);
        },
      },
    ];
  }
}
