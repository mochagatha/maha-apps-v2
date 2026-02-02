import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/widgets/custom_app_bar.dart';

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
            return _buildMenuItem(context, item);
          },
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, Map<String, dynamic> item) {
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
          onTap: item['action'] as VoidCallback?,
          borderRadius: BorderRadius.circular(8),
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
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
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
