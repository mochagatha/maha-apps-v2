import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

/// Profile points card widget
class ProfilePointsCard extends StatelessWidget {
  final double points;

  const ProfilePointsCard({
    super.key,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.neutral2,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(8.0),
          bottomRight: Radius.circular(8.0),
        ),
      ),
      child: Row(
        children: [
          // Gold icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.stars_rounded,
              color: Color(0xFFB78805),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          // Points info
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Poin saat ini',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFB78805),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _formatPoints(points),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFB78805),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatPoints(double points) {
    return points.toStringAsFixed(1);
  }
}
