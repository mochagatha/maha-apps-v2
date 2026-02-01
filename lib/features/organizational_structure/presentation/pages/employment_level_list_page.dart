import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

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
            return _buildMenuItem(context, item, index);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: index < 1 ? 16 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.shade300,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push(item['route'] as String);
          },
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                SvgPicture.asset(
                  item['icon'] as String,
                  height: 40,
                  width: 40,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
