import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../shared/theme/app_theme.dart';

class WelcomeMenuGrid extends StatelessWidget {
  const WelcomeMenuGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> gridItems = [
      {
        'icon': 'assets/images/icon/absensi.png',
        'label': 'Absensi',
        'action': () => context.pushNamed(AppRoutes.absensi.name),
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/approval.png',
        'label': 'Approval',
        'action': () => context.pushNamed(AppRoutes.approvalList.name),
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/rencanakerja.png',
        'label': 'Rencana Kerja',
        'action': () {},
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/permintaan.png',
        'label': 'Permintaan',
        'action': () => context.pushNamed(AppRoutes.permintaan.name),
        'isAsset': true,
      },
      {'icon': 'assets/images/icon/tugas.png', 'label': 'Tugas', 'action': () {}, 'isAsset': true},
      {
        'icon': 'assets/images/icon/pengajuan.png',
        'label': 'Pengajuan',
        'action': () {},
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/administrasi.png',
        'label': 'Administrasi',
        'action': () => context.pushNamed(AppRoutes.administration.name),
        'isAsset': true,
      },
      {
        'icon': 'assets/images/icon/arsip.png',
        'label': 'Arsip',
        'action': () => context.pushNamed(AppRoutes.archiveMenu.name),
        'isAsset': true,
      },
    ];

    return GridView.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(gridItems.length, (index) {
        return GestureDetector(
          onTap: gridItems[index]['action'],
          child: Column(
            children: [
              gridItems[index]['isAsset']
                  ? Image.asset(gridItems[index]['icon'], width: 50, height: 50)
                  : Icon(
                      gridItems[index]['icon'],
                      size: 40,
                      color: AppColors.primary,
                    ),
              const SizedBox(height: 8),
              Text(
                gridItems[index]['label'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
