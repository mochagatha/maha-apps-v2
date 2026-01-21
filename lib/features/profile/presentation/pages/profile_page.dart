import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_menu_list.dart';
import '../../../../core/di/injection_container.dart';

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

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<ProfileProvider>()..loadProfile(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/home'),
          ),
          title: const Text(
            'Profil',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<ProfileProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading && provider.employee == null) {
              return const Center(
                child: SpinKitThreeBounce(color: AppColors.primary, size: 50.0),
              );
            }

            // Error state
            if (provider.hasError && provider.employee == null) {
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
                      provider.errorMessage ?? 'An error occurred',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => provider.loadProfile(),
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            }

            final employee = provider.employee;
            final isWorker = employee?.type == 'worker';

            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: _showPhotoDialog,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.grey[200],
                                    backgroundImage: employee?.photoUrl != null
                                        ? NetworkImage(employee!.photoUrl!)
                                        : const AssetImage(
                                                'assets/images/user_placeholder.png',
                                              )
                                              as ImageProvider,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        employee?.fullname ?? '-',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.addressCard,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            employee?.nik ?? '-',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const FaIcon(
                                            FontAwesomeIcons.envelope,
                                            size: 12,
                                            color: Colors.grey,
                                          ),
                                          const SizedBox(width: 8),
                                          Flexible(
                                            child: Text(
                                              employee?.email ?? '-',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[600],
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
                          // Points Section
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icon/logo_emas.svg',
                                      height: 32,
                                      width: 32,
                                      // Fallback if asset missing
                                      placeholderBuilder: (context) =>
                                          const Icon(
                                            Icons.stars,
                                            color: Colors.amber,
                                            size: 32,
                                          ),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Poin saat ini',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffB78805),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          isWorker
                                              ? '0 poin'
                                              : '${employee?.totalPoint.toStringAsFixed(0) ?? 0} poin',
                                          style: const TextStyle(
                                            color: Color(0xffB78805),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // Tukar Poin Button
                                GestureDetector(
                                  onTap: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Feature coming soon!'),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffB78805),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.receipt_long,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4),
                                        Text(
                                          'Tukar Poin',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Monitoring Card
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffEFEEEE), Color(0xff292D32)],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Opacity(
                              opacity: 0.1,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/images/logo_maha.svg',
                                  width: 100,
                                  placeholderBuilder: (context) =>
                                      const SizedBox(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Kamu sedang dalam\npemantauan nih!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      employee?.fullname ?? '-',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Row(
                              children: [
                                Container(
                                  width: 12,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Container(
                                  width: 12,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Fitur Section
                    ProfileMenuList(
                      title: 'FITUR',
                      items: [
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/data_diri_profile.svg',
                          label: 'Data Diri',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/performa.svg',
                          label: 'Performa',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/administrasi.svg',
                          label: 'Administrasi',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/entypo_wallet.svg',
                          label: 'Slip Gaji',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/slip_hutang_icon.svg',
                          label: 'Slip Hutang',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Preferensi Section
                    ProfileMenuList(
                      title: 'PREFERENSI',
                      items: [
                        // Placeholder for Pengunduran Diri since icon might be missing
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/log_out.svg',
                          label: 'Pengunduran Diri',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/keamanan_akun.svg',
                          label: 'Ubah Kata Sandi',
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Feature coming soon!'),
                              ),
                            );
                          },
                        ),
                        ProfileMenuItem(
                          assetPath: 'assets/images/icon/log_out.svg',
                          label: 'Keluar',
                          textColor: Colors.red,
                          onTap: () {
                            _showLogoutDialog(context);
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Footer
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            'Application Version : 1.0.0',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '©opyright IT MAHA  ${DateTime.now().year}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // These methods are no longer used as the menu items are defined directly in the build method.
  // List<ProfileMenuItem> _buildFeatureMenuItems(BuildContext context) {
  //   return [
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/data_diri_profile.svg',
  //       label: context
  //           .l10n
  //           .dataDiri, // Assuming this key exists, or use 'Data Diri'
  //       onTap: () {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/performa.svg',
  //       label: 'Performa',
  //       onTap: () {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/administrasi.svg',
  //       label: 'Administrasi',
  //       onTap: () {
  //         // alertSoon(context); in V1
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/entypo_wallet.svg',
  //       label: 'Slip Gaji',
  //       onTap: () {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/slip_hutang_icon.svg',
  //       label: 'Slip Hutang',
  //       onTap: () {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //   ];
  // }

  // List<ProfileMenuItem> _buildPreferencesMenuItems(BuildContext context) {
  //   return [
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/keamanan_akun.svg',
  //       label: context.l10n.changePassword, // or 'Ubah Kata Sandi'
  //       onTap: () {
  //         ScaffoldMessenger.of(
  //           context,
  //         ).showSnackBar(const SnackBar(content: Text('Feature coming soon')));
  //       },
  //     ),
  //     ProfileMenuItem(
  //       assetPath: 'assets/images/icon/log_out.svg',
  //       label: context.l10n.logout,
  //       onTap: () => _showLogoutDialog(context),
  //     ),
  //   ];
  // }

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
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.logout,
                    size: 64,
                    color: AppColors.primary,
                  ),
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
                  style: TextStyle(fontSize: 14),
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
                          await context.read<AuthProvider>().logoutUser();

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
}
