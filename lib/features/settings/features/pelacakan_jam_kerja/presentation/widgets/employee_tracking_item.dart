import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../domain/entities/tracking_employee.dart';

class EmployeeTrackingItem extends StatelessWidget {
  final TrackingEmployee employee;
  final ValueChanged<bool> onToggle;

  const EmployeeTrackingItem({
    super.key,
    required this.employee,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            AppRoutes.pelacakanEmployeeDetail.name,
            pathParameters: {'id': employee.id.toString()},
          );
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                backgroundImage: employee.photoUrl != null
                    ? NetworkImage(employee.photoUrl!)
                    : null,
                child: employee.photoUrl == null
                    ? Text(
                        employee.fullname.isNotEmpty ? employee.fullname[0].toUpperCase() : '?',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 12),

              // Employee Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.fullname,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      employee.jobTitleName,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // Toggle Switch
              Switch(
                value: employee.isTrackingEnabled,
                onChanged: onToggle,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
