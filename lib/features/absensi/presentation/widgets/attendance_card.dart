import 'package:flutter/material.dart';

class AttendanceCard extends StatelessWidget {
  final String title;
  final String? time;
  final String? photoUrl;
  final int colorStatus;
  final bool isLate;
  final int clockType; // 1: camera, 2: fingerprint

  const AttendanceCard({
    super.key,
    required this.title,
    this.time,
    this.photoUrl,
    required this.colorStatus,
    this.isLate = false,
    this.clockType = 1,
  });

  Color _getStatusColor() {
    // Based on V1 logic
    switch (colorStatus) {
      case 0:
        return const Color(0xff67EA95); // On time
      case 1:
        return const Color(0xffFFE56C); // Late
      case 2:
        return const Color(0xff67EA95); // On time
      case 3:
        return const Color(0xffFFE56C); // Late
      case 4:
        return const Color(0xffE91E21); // Very late
      case 6:
        return const Color(0xffF4F4F4); // Not yet
      case 20:
        return const Color(0xff7A5401); // Overtime
      default:
        return const Color(0xffF4F4F4);
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();
    final hasTime = time != null && time != '-' && time != 'null';
    
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: clockType == 2
                ? const Icon(
                    Icons.fingerprint,
                    size: 24,
                  )
                : Container(
                    padding: const EdgeInsets.all(5.5),
                    decoration: BoxDecoration(
                      color: hasTime && photoUrl != null && photoUrl!.isNotEmpty
                          ? Colors.transparent
                          : Colors.grey,
                      shape: BoxShape.circle,
                      image: hasTime && photoUrl != null && photoUrl!.isNotEmpty
                          ? DecorationImage(
                              image: NetworkImage(photoUrl!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: hasTime && photoUrl != null && photoUrl!.isNotEmpty
                            ? Colors.transparent
                            : Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              hasTime ? time!.substring(0, time!.length > 5 ? 5 : time!.length) : '--:--',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
