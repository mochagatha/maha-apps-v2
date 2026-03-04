import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/router/app_routes.dart';
import 'package:maha_apps_v2/features/recruitment/domain/entities/recruitment_menu_item.dart';
import 'package:maha_apps_v2/features/recruitment/presentation/widgets/recruitment_menu_card.dart';
import 'package:maha_apps_v2/shared/widgets/custom_app_bar.dart';

class EMatraiPage extends StatelessWidget {
  const EMatraiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Upload E-Matrai"),
      body: ListView(
        children: [
          RecruitmentMenuCard(
            menuItem: RecruitmentMenuItem(
              id: "0",
              label: "Karyawan",
              icon: "assets/images/icon/karyawan_icon.svg",
            ),
            onTap: () => context.push(AppRoutes.employeeEMatrai.path),
          ),
          RecruitmentMenuCard(
            menuItem: RecruitmentMenuItem(
              id: "0",
              label: "Pekerja Harian",
              icon: "assets/images/icon/pekerja_harian_icon.svg",
            ),
            onTap: () => context.push(
              AppRoutes.employeeEMatrai.path,
              extra: {'type_user': 'worker'},
            ),
          ),
        ],
      ),
    );
  }
}
