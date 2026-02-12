
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/shared/widgets/menu_item_card.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../core/router/app_routes.dart';

class PelacakanJamKerjaPage extends StatelessWidget {
  const PelacakanJamKerjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pelacakan Jam Kerja'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MenuItemCard(
              asset: 'assets/icons/settings/karyawan.png',
              title: 'Karyawan',
              onTap: () {
                context.pushNamed(
                  AppRoutes.pelacakanSettings.name,
                  queryParameters: {'type': 'karyawan'},
                );
              },
            ),
            MenuItemCard(
              asset: 'assets/icons/settings/pekerja_harian.png',
              title: 'Pekerja Harian',
              onTap: () {
                context.pushNamed(
                  AppRoutes.pelacakanSettings.name,
                  queryParameters: {'type': 'pekerja_harian'},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}