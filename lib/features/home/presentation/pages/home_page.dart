import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/home_provider.dart';
import '../widgets/menu_grid.dart';
import '../widgets/profile_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Load home data when page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final homeProvider = context.read<HomeProvider>();
      homeProvider.loadHomeData();
      homeProvider.startPolling();
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
      context.read<HomeProvider>().startPolling();
    } else if (state == AppLifecycleState.paused) {
      context.read<HomeProvider>().stopPolling();
    }
  }

  Future<void> _onRefresh() async {
    await context.read<HomeProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          if (homeProvider.isLoading && homeProvider.employee == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }

          if (homeProvider.hasError && homeProvider.employee == null) {
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
                    homeProvider.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => homeProvider.loadHomeData(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    // Profile Card
                    ProfileCard(
                      employee: homeProvider.employee,
                      notificationCount: homeProvider.notificationCount,
                    ),

                    const SizedBox(height: 24),

                    // Menu Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: MenuGrid(
                        menus: homeProvider.menus,
                        notificationCount: homeProvider.notificationCount,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Copyright
                    Text(
                      context.l10n.copyright(DateTime.now().year.toString()),
                      style: const TextStyle(
                        color: AppColors.neutral5,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
