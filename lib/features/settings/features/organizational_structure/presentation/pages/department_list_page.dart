import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';

class DepartmentListPage extends StatelessWidget {
  const DepartmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {
        'icon': 'assets/images/icon/jam_kerja.svg',
        'text': 'Kantor',
        'route': AppRoutes.departmentOffice.path,
      },
      {
        'icon': 'assets/images/icon/pengaturan_lembur.svg',
        'text': 'Proyek',
        'route': AppRoutes.departmentProject.path,
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Data Departemen',
      ),
      body: RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          // Refresh logic if needed
        },
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                context.push(item['route'] as String);
              },
              child: Container(
                margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.grey.shade300,
                      offset: const Offset(3, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      item['icon'] as String,
                      height: 40,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      item['text'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.keyboard_arrow_right),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
