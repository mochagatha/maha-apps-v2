import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/utils/localization_extension.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';

class VerificationDataPage extends StatelessWidget {
  const VerificationDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Moved inside build to access context
    final List<Map<String, dynamic>> menuItems = [
      {
        'icon': 'assets/images/icon/karyawan_icon.svg',
        'text': context.l10n.employee, // "Karyawan"
        'count': 0,
        'route': '/recruitment/employee-verification',
      },
      {
        'icon': 'assets/images/icon/pekerja_harian_icon.svg',
        'text': context.l10n.dailyWorker, // "Pekerja Harian"
        'count': 0,
        'action': () {
          // TODO: Navigate to worker verification list
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.l10n.dailyWorkerVerificationComingSoon),
            ),
          );
        },
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.verificationJobLevelTitle,
      ),
      body: RefreshIndicator(
        color: AppColors.primary,
        onRefresh: () async {
          // Refresh logic if needed
          await Future.delayed(const Duration(milliseconds: 500));
        },
        child: ListView.builder(
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (item['route'] != null) {
                      context.push(item['route'] as String);
                    } else if (item['action'] != null) {
                      (item['action'] as VoidCallback)();
                    }
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
                          placeholderBuilder: (context) =>
                              const Icon(Icons.error, size: 40),
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
                ),
                if ((item['count'] as int) != 0)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${item['count']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
