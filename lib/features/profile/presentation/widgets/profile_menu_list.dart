import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

/// Profile menu item model
class ProfileMenuItem {
  final String icon;
  final String label;
  final VoidCallback onTap;

  const ProfileMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });
}

/// Profile menu list widget
class ProfileMenuList extends StatelessWidget {
  final String title;
  final List<ProfileMenuItem> items;

  const ProfileMenuList({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.neutral6,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: AppColors.neutral4,
              width: 0.5,
            ),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => _buildMenuItem(
                item: items[index],
                isLast: index == items.length - 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required ProfileMenuItem item,
    required bool isLast,
  }) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : const BorderSide(
                    color: AppColors.neutral4,
                    width: 0.5,
                  ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 12,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  _getIconData(item.icon),
                  size: 20,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: AppColors.neutral6,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person_outline;
      case 'school':
        return Icons.school_outlined;
      case 'work':
        return Icons.work_outline;
      case 'family':
        return Icons.family_restroom_outlined;
      case 'lock':
        return Icons.lock_outline;
      case 'security':
        return Icons.security_outlined;
      case 'settings':
        return Icons.settings_outlined;
      case 'logout':
        return Icons.logout;
      default:
        return Icons.circle_outlined;
    }
  }
}
