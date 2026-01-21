import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/notification_count.dart';

class ProfileCard extends StatelessWidget {
  final Employee? employee;
  final NotificationCount? notificationCount;

  const ProfileCard({super.key, this.employee, this.notificationCount});

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
      builder: (BuildContext dialogContext) {
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
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.logout,
                    size: 64,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    text: context.l10n.logoutConfirmation1,
                    children: <TextSpan>[
                      TextSpan(
                        text: context.l10n.logoutConfirmation2,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: context.l10n.logoutConfirmation3),
                    ],
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          // Perform logout first
                          await context.read<AuthProvider>().logoutUser();

                          // Navigate to login after current frame completes
                          // This ensures all dialogs are properly cleaned up
                          if (context.mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (context.mounted) {
                                context.go(RoutePaths.login);
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: const BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Text(context.l10n.yes),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Text(context.l10n.cancel),
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
    final hasNotifications = (notificationCount?.notificationCount ?? 0) > 0;
    // Fallback image if null
    final photoUrl = employee?.biodata?.photoUrl;
    final fullName = employee?.fullname ?? 'Visitor';
    final jobTitle = employee?.jobTitleName ?? 'Guest';

    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          // Background Blur Image (V1 decoration)
          // We can put it here, or in the parent. Let's keep it here but make sure it aligns.
          Container(
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: 0.3, // Subtle effect
              child: Image.asset(
                'assets/images/maha-blur.png',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 150,
                errorBuilder: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
              bottom: 40.0,
            ), // Extra bottom padding for overlap space
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side: Avatar and Info
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Avatar
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: CircleAvatar(
                          radius: 28, // Slightly larger
                          backgroundColor: Colors.grey[200],
                          backgroundImage: photoUrl != null
                              ? NetworkImage(photoUrl)
                              : null,
                          child: photoUrl == null
                              ? Text(
                                  _getInitials(fullName),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primary,
                                  ),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Info
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            context.push(RoutePaths.profile);
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                fullName,
                                style: const TextStyle(
                                  fontSize: 16, // Larger font
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  jobTitle,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
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
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(
                            Icons.notifications_none_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                          if (hasNotifications)
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Logout Icon
                    GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: const Icon(
                        Icons.logout, // Or specific door icon if available
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
