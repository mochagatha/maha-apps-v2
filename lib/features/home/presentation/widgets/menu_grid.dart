import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
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
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.9,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: menus.length,
      itemBuilder: (context, index) {
        final menu = menus[index];
        final badgeCount = _getMenuBadgeCount(menu.name);

        return GestureDetector(
          onTap: () {
            // TODO: Navigate based on menu.id or menu.name
            debugPrint('Tapped menu: ${menu.name}');
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with badge
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Icon display
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: menu.isAsset
                          ? Image.asset(
                              menu.icon,
                              width: 48,
                              height: 48,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.apps,
                                  size: 48,
                                  color: AppColors.primary,
                                );
                              },
                            )
                          : menu.icon.startsWith('http')
                              ? Image.network(
                                  menu.icon,
                                  width: 48,
                                  height: 48,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.apps,
                                      size: 48,
                                      color: AppColors.primary,
                                    );
                                  },
                                )
                              : Icon(
                                  _getIconData(menu.icon),
                                  size: 48,
                                  color: AppColors.primary,
                                ),
                    ),
                    if (badgeCount > 0)
                      Positioned(
                        top: -4,
                        right: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            badgeCount > 99 ? '99+' : '$badgeCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),

                // Label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    menu.label,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral9,
                      height: 1.2,
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
