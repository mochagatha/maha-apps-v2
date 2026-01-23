import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Profile menu item model
class ProfileMenuItem {
  final String assetPath;
  final String label;
  final VoidCallback onTap;
  final Color? textColor;

  const ProfileMenuItem({
    required this.assetPath,
    required this.label,
    required this.onTap,
    this.textColor,
  });
}

/// Profile menu list widget
class ProfileMenuList extends StatelessWidget {
  final String title;
  final List<ProfileMenuItem> items;

  const ProfileMenuList({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xff5F5F5F),
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(1.5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey, width: 0.5),
          ),
          child: Column(
            children: List.generate(
              items.length,
              (index) => _buildMenuItem(item: items[index], isLast: index == items.length - 1),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({required ProfileMenuItem item, required bool isLast}) {
    return InkWell(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast ? BorderSide.none : const BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  item.assetPath,
                  width: 24, // Estimate size matching V1 likely around 24-30
                  height: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 13.0,
                    color: item.textColor ?? Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        ),
      ),
    );
  }
}
