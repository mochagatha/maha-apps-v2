import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
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
    if (fullname.isEmpty) return 'U';
    final names = fullname.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'U';
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 120,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/icon/logout.png',
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.logout, size: 50, color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    text: 'Apakah Anda yakin ingin ',
                    children: <TextSpan>[
                      TextSpan(
                        text: 'keluar ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: 'dari aplikasi ?'),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Perform logout
                          final authProvider = context.read<AuthProvider>();
                          final nav = Navigator.of(context);
                          
                          // Close dialog first
                          nav.pop();
                          
                          // Call logout
                          await authProvider.logoutUser();
                          
                          // Navigate to login
                          if (context.mounted) {
                            context.go(RoutePaths.login);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: const Text('Ya'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Batal'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // If employee is null, we can still show a skeleton or return mostly empty, 
    // but the parent checks for null usually. 
    // We'll handle it gracefully just in case.
    
    final hasNotifications = (notificationCount?.notificationCount ?? 0) > 0;
    // Fallback image if null
    final photoUrl = employee?.biodata?.photoUrl;
    final fullName = employee?.fullname ?? 'Visitor';
    final jobTitle = employee?.jobTitleName ?? 'Guest';

    return Stack(
      children: [
        Container(
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
                // Left side: Avatar and Info
                Expanded(
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 23,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl)
                            : null,
                        child: photoUrl == null
                            ? Text(
                                _getInitials(fullName),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              )
                            : null,
                      ),
                      const SizedBox(width: 10),
                      // Info
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(RoutePaths.profile);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                jobTitle,
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
                
                // Right side: Icons
                Row(
                  children: [
                    // Notification Icon
                    GestureDetector(
                      onTap: () {
                        // TODO: Notification Screen
                      },
                      child: Stack(
                        children: [
                          const Icon(Icons.notifications, color: Colors.white, size: 25),
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
                    const SizedBox(width: 10),
                    // Logout Icon
                    GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: const Icon(
                        Icons.logout, // Using standard icon instead of FontAwesome for now
                        color: Colors.white, 
                        size: 20 // Slightly smaller like V1
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Blur Effect Image (V1 decoration)
        Container(
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(top: 20),
          child: Image.asset(
            'assets/images/maha-blur.png',
            width: 250,
            height: 120,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(), // Hides if missing
          ),
        ),
        
        // Notification Badge Overlay on Avatar (Like in V1, though it was redundant there, we keep it if desired)
        // V1 had a badge on the avatar implementation too.
        if (hasNotifications)
          Positioned(
            top: 55, // Adjust based on layout
            left: 12 + 46.0 - 15, // Approx avatar width helpers
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
               constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
              child: Text(
                '${notificationCount!.notificationCount}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
