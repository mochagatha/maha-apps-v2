import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItemCard extends StatelessWidget {
  const MenuItemCard({super.key, this.asset, required this.title, required this.onTap});
  final String? asset;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.shade300, offset: const Offset(3, 3)),
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
                if (asset != null) ...[
                  asset!.toLowerCase().endsWith('.svg')
                      ? SvgPicture.asset(asset!, height: 40, width: 40)
                      : Image.asset(asset!, height: 40, width: 40),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
