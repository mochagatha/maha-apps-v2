import 'package:flutter/material.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../domain/entities/kpi.dart';

class PointsCard extends StatelessWidget {
  final Kpi? kpi;

  const PointsCard({super.key, this.kpi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      // height: 80, // Allow flexible height
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icon/home-poin.png',
              width: 42,
              height: 42,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.monetization_on,
                color: Colors.amber,
                size: 42,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: '${kpi?.totalPoint ?? 0}/${kpi?.targetPoint ?? 0} ',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontFamily: 'Poppins',
                      ),
                      children: [
                        TextSpan(
                          text: context.l10n.points,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: kpi?.percentage != null
                          ? (kpi!.percentage! / 100).clamp(0.0, 1.0)
                          : ((kpi?.targetPoint ?? 0) > 0
                                ? ((kpi?.totalPoint ?? 0) / (kpi!.targetPoint!))
                                      .clamp(0.0, 1.0)
                                : 0.0),
                      backgroundColor: Colors.grey[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFFFFC107), // Amber/Yellow
                      ),
                      minHeight: 6,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    () {
                      final current = kpi?.totalPoint ?? 0;
                      final target = kpi?.targetPoint ?? 0;
                      final remaining = (target - current).clamp(0, target);

                      if (target > 0 && current >= target) {
                        return context.l10n.targetReachedSimplified;
                      }
                      return context.l10n.pointsNotReached(remaining);
                    }(),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[600],
                      fontFamily: 'Poppins',
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
