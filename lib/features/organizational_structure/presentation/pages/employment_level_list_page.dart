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
        'title': 'Tingkatan Karyawan',
        'icon': 'assets/images/icon/icon_karyawan.svg',
        'route': RoutePaths.employmentLevelEmployee,
      },
      {
        'title': 'Tingkatan Pekerja',
        'icon': 'assets/images/icon/icon_pekerja.svg',
        'route': RoutePaths.employmentLevelWorker,
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Data Tingkatan Pekerjaan',
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      item['icon'] as String,
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        item['title'] as String,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
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
