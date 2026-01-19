import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../utils/menu_mapper.dart';
import '../../domain/entities/menu_item.dart';
import '../../domain/entities/notification_count.dart';

class MenuGrid extends StatelessWidget {
  final List<MenuItem> menus;
  final NotificationCount? notificationCount;

  const MenuGrid({
    super.key,
    required this.menus,
    this.notificationCount,
  });

  int _getMenuBadgeCount(String menuName) {
    if (notificationCount == null) return 0;

    // Map menu names to notification counts
    switch (menuName.toLowerCase()) {
      case 'approval':
      case 'persetujuan':
        return notificationCount!.approvalCount;
      case 'request':
      case 'permintaan':
        return notificationCount!.approvalRequest;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (menus.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            'No menu items available',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.neutral6,
            ),
          ),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 6 : 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1 : 0.8,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        final badgeCount = _getMenuBadgeCount(menu.name);

        // Get details from MenuMapper
        // We use menu.name as 'id' because in V1 allHomeMenu checks 'id': AppConstants.menu.absensi
        // and MenuItemModel.toEntity() maps 'id' to 'id'.
        // However, let's make sure we pass the correct identifier.
        // It seems menu.name in V2 might be the identifier we want if it matches V1 keys.
        // Let's assume menu.id matches the keys in MenuMapper for now.
        final details = MenuMapper.getMenuDetails(menu.name); // Using name as V1 used name/id interchangeably or specific constants
        final iconAsset = details['icon'] as String;
        final route = details['route'] as String?;
        final isAsset = details['isAsset'] as bool? ?? true;

        return GestureDetector(
          onTap: () {
            if (route != null) {
              context.push(route);
            } else {
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Feature ${menu.label} coming soon!')),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: MediaQuery.of(context).size.width > 600
                  ? Colors.white
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: MediaQuery.of(context).size.width > 600
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      )
                    ]
                  : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    isAsset
                        ? Image.asset(
                            iconAsset,
                            width: MediaQuery.of(context).size.width > 600 ? 60 : 50,
                            height: MediaQuery.of(context).size.width > 600 ? 60 : 50,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          )
                        : Icon(
                            Icons.apps, 
                            size: MediaQuery.of(context).size.width > 600 ? 50 : 40,
                            color: AppColors.primary,
                          ),
                    if (badgeCount > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            badgeCount > 99 ? '99+' : '$badgeCount',
                            style: const TextStyle(
                              fontSize: 7,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Flexible(
                  child: Text(
                    menu.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconData(String iconName) {
    // Map string icon names to IconData
    switch (iconName.toLowerCase()) {
      case 'home':
        return Icons.home;
      case 'person':
        return Icons.person;
      case 'calendar':
        return Icons.calendar_today;
      case 'chat':
        return Icons.chat;
      case 'approval':
        return Icons.check_circle;
      case 'attendance':
        return Icons.access_time;
      case 'leave':
        return Icons.event_busy;
      case 'overtime':
        return Icons.schedule;
      default:
        return Icons.apps;
    }
  }
}
