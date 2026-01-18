import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_menu_list.dart';
import '../widgets/profile_points_card.dart';

/// Profile page displaying employee profile and menu options
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    // Load profile data when page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadProfile();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<ProfileProvider>().refresh();
  }

  void _showPhotoDialog() {
    // TODO: Implement photo dialog with options to view/change photo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.profilePicture),
        content: const Text('Feature coming soon'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.close),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.profile),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          // Loading state
          if (profileProvider.isLoading && profileProvider.employee == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          // Error state
          if (profileProvider.hasError && profileProvider.employee == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profileProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => profileProvider.loadProfile(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          final employee = profileProvider.employee;

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Header with Photo and Basic Info
                  ProfileHeader(
                    employee: employee,
                    onPhotoTap: _showPhotoDialog,
                  ),

                  // Points Card
                  if (employee != null && employee.type != 'worker')
                    ProfilePointsCard(
                      points: employee.totalPoint,
                    ),

                  const SizedBox(height: 24),

                  // Feature Menu List
                  ProfileMenuList(
                    title: context.l10n.profileFeatures,
                    items: _buildFeatureMenuItems(context),
                  ),

                  const SizedBox(height: 24),

                  // Preferences Menu List
                  ProfileMenuList(
                    title: context.l10n.profilePreferences,
                    items: _buildPreferencesMenuItems(context),
                  ),

                  const SizedBox(height: 32),

                  // App Version Footer
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Application Version: 2.0.0',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: AppColors.neutral5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.copyright(DateTime.now().year.toString()),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: AppColors.neutral6,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<ProfileMenuItem> _buildFeatureMenuItems(BuildContext context) {
    return [
      ProfileMenuItem(
        icon: 'person',
        label: context.l10n.dataDiri,
        onTap: () {
          // TODO: Navigate to Data Diri page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
      ProfileMenuItem(
        icon: 'school',
        label: context.l10n.education,
        onTap: () {
          // TODO: Navigate to Education page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
      ProfileMenuItem(
        icon: 'work',
        label: context.l10n.skill,
        onTap: () {
          // TODO: Navigate to Skill page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
      ProfileMenuItem(
        icon: 'family',
        label: context.l10n.family,
        onTap: () {
          // TODO: Navigate to Family page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
    ];
  }

  List<ProfileMenuItem> _buildPreferencesMenuItems(BuildContext context) {
    return [
      ProfileMenuItem(
        icon: 'lock',
        label: context.l10n.changePassword,
        onTap: () {
          // TODO: Navigate to Change Password page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
      ProfileMenuItem(
        icon: 'security',
        label: context.l10n.secureAccount,
        onTap: () {
          // TODO: Navigate to Security page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Feature coming soon')),
          );
        },
      ),
    ];
  }
}
