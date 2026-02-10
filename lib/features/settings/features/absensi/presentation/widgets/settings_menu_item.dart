import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Reusable settings menu item widget
/// Displays an icon, title, and navigation arrow
class SettingsMenuItem extends StatelessWidget {
  /// Path to the icon asset (supports both PNG and SVG)
  final String iconPath;

  /// Title text to display
  final String title;

  /// Callback when the item is tapped
  final VoidCallback onTap;

  /// Optional badge count (shows if > 0)
  final int? badgeCount;

  const SettingsMenuItem({
    super.key,
    required this.iconPath,
    required this.title,
    required this.onTap,
    this.badgeCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.shade300,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon
                _buildIcon(),
                const SizedBox(width: 16),

                // Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),

                // Badge (if any)
                if (badgeCount != null && badgeCount! > 0) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      badgeCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],

                // Arrow icon
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final isSvg = iconPath.toLowerCase().endsWith('.svg');

    return SizedBox(
      height: 40,
      width: 40,
      child: isSvg
          ? SvgPicture.asset(
              iconPath,
              height: 40,
              width: 40,
              // ignore: deprecated_member_use
              color: null,
              fit: BoxFit.contain,
            )
          : Image.asset(
              iconPath,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.settings,
                  size: 40,
                  color: Colors.grey,
                );
              },
            ),
    );
  }
}
