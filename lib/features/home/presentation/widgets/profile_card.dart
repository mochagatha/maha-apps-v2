import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/notification_count.dart';

class ProfileCard extends StatelessWidget {
  final Employee? employee;
  final NotificationCount? notificationCount;

  const ProfileCard({
    super.key,
    this.employee,
    this.notificationCount,
  });

  String _getInitials(String fullname) {
    final names = fullname.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'U';
  }

  @override
  Widget build(BuildContext context) {
    if (employee == null) {
      return const SizedBox.shrink();
    }

    final hasNotifications = (notificationCount?.notificationCount ?? 0) > 0;

    return Container(
      height: 160,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Avatar and Employee Info
            Expanded(
              child: Row(
                children: [
                  // Avatar (no border, smaller)
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: employee!.biodata?.photoUrl != null
                            ? NetworkImage(employee!.biodata!.photoUrl!)
                            : null,
                        child: employee!.biodata?.photoUrl == null
                            ? Text(
                                _getInitials(employee!.fullname),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              )
                            : null,
                      ),
                      if (hasNotifications)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 18,
                              minHeight: 18,
                            ),
                            child: Text(
                              '${notificationCount!.notificationCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 10),

                  // Employee Info
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.go(RoutePaths.profile);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            employee!.fullname,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            employee!.jobTitleName,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right side: Notification Bell
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to notification page
                  },
                  child: Stack(
                    children: [
                      const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                      if (hasNotifications)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    context.go(RoutePaths.profile);
                  },
                  child: const Icon(
                    Icons.person_outline,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
