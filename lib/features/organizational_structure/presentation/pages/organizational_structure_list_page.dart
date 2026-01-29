import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

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
            return _buildMenuItem(context, item);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
    final bool isEnabled = item['enabled'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.shade300, offset: const Offset(3, 3)),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isEnabled ? item['action'] as VoidCallback? : null,
          borderRadius: BorderRadius.circular(8),
          child: Opacity(
            opacity: isEnabled ? 1.0 : 0.5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  SvgPicture.asset(item['icon'] as String, height: 40, width: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      item['text'] as String,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_right, color: isEnabled ? Colors.black : Colors.grey),
                ],
              ),
            ),
          ),
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
