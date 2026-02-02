import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/admin_home_provider.dart';
import '../widgets/menu_grid.dart';
import '../widgets/admin_profile_card.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Load admin home data when page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final adminHomeProvider = context.read<AdminHomeProvider>();
      adminHomeProvider.loadHomeData();
      adminHomeProvider.startPolling();
    });

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AdminHomeProvider>().startPolling();
    } else if (state == AppLifecycleState.paused) {
      context.read<AdminHomeProvider>().stopPolling();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<AdminHomeProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<AdminHomeProvider>(
        builder: (context, adminHomeProvider, child) {
          if (adminHomeProvider.isLoading && adminHomeProvider.menus.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: AppColors.primary, size: 50.0));
          }

          if (adminHomeProvider.hasError && adminHomeProvider.menus.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    adminHomeProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => adminHomeProvider.loadHomeData(),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          return Stack(
            children: [
              // 1. Red Background Header (Fixed height)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 140, // Reduced height for better proportion
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
              ),

              // 2. Scrollable Content
              SafeArea(
                top: false,
                child: RefreshIndicator(
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        // Admin Profile Card (Header content)
                        AdminProfileCard(notificationCount: adminHomeProvider.notificationCount),

                        const SizedBox(height: 16),

                        // Menu Grid
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: MenuGrid(
                            menus: adminHomeProvider.menus,
                            notificationCount: adminHomeProvider.notificationCount,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Version & Copyright
                        Text(
                          context.l10n.appVersion('1.0.0'),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          context.l10n.copyright(DateTime.now().year.toString()),
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
