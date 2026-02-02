import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/employee.dart';

/// Profile header widget displaying employee photo and basic info
class ProfileHeader extends StatelessWidget {
  final Employee? employee;
  final VoidCallback? onPhotoTap;

  const ProfileHeader({
    super.key,
    required this.employee,
    this.onPhotoTap,
  });

  @override
  Widget build(BuildContext context) {
    if (employee == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.neutral4,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                // Profile Photo
                GestureDetector(
                  onTap: onPhotoTap,
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.neutral3,
                    backgroundImage: employee!.photoUrl != null
                        ? NetworkImage(employee!.photoUrl!)
                        : null,
                    child: employee!.photoUrl == null
                        ? const Icon(
                            Icons.person,
                            size: 32,
                            color: AppColors.neutral5,
                          )
                        : null,
                  ),
                ),
                const SizedBox(width: 12),
                // Employee Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee!.fullname,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.badge_outlined,
                            size: 14,
                            color: AppColors.neutral6,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              employee!.nik,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.neutral6,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            Icons.email_outlined,
                            size: 14,
                            color: AppColors.neutral6,
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              employee!.email,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.neutral6,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
