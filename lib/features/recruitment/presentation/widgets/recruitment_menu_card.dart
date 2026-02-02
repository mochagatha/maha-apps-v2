import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/recruitment_menu_item.dart';

class RecruitmentMenuCard extends StatelessWidget {
  final RecruitmentMenuItem menuItem;
  final VoidCallback onTap;

  const RecruitmentMenuCard({
    super.key,
    required this.menuItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
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
                // Icon - support both SVG and PNG
                _buildIcon(),
                const SizedBox(width: 10),
                // Label
                Text(
                  menuItem.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                // Arrow icon
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        // Notification badge
        if (menuItem.count > 0)
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
                '${menuItem.count}',
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
  }

  Widget _buildIcon() {
    // Check if icon is SVG or PNG
    if (menuItem.icon.endsWith('.svg')) {
      return SvgPicture.asset(
        menuItem.icon,
        height: 40,
        // Fallback to error icon if asset not found
        placeholderBuilder: (context) => const Icon(Icons.error, size: 40),
      );
    } else {
      return Image.asset(
        menuItem.icon,
        height: 40,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.error, size: 40),
      );
    }
  }
}
