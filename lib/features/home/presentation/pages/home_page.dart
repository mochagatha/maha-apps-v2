import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../providers/home_provider.dart';
import '../widgets/menu_grid.dart';
import '../widgets/profile_card.dart';
import '../widgets/points_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  bool _isDialogShowing = false;

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

  void _checkStatus(BuildContext context, int status) {
    if (_isDialogShowing) return;

    if (status == 8) {
      // Rejected
      _isDialogShowing = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            // Replaces WillPopScope
            canPop: false,
            child: AlertDialog(
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
                      'assets/images/icon/success-register.png',
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.warning,
                        size: 50,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      context.l10n.statusRejectedTitle,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate safely to Reject screen logic if it exists
                          // For now just close or stay, but V1 pushes RejectStatementScreen
                          // We don't have that route yet, so we just show snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10n.rejectStatusDetailsComingSoon,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: Text(context.l10n.checkDetails),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ).then((_) => _isDialogShowing = false);
    } else if (status != 3) {
      // Not Active (Active is 3)
      _isDialogShowing = true;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
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
                      'assets/images/icon/success-register.png',
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.info, size: 50, color: Colors.blue),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      status == 4
                          ? context.l10n.statusInactive
                          : status == 5
                          ? context.l10n.statusBlacklisted
                          : status == 10
                          ? context.l10n.statusContractUnverified
                          : context.l10n.statusInaccessible,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          final encodedMessage = Uri.encodeFull(
                            status == 4
                                ? context.l10n.contactAdminMessageInactive
                                : status == 5
                                ? context.l10n.contactAdminMessageBlacklisted
                                : status == 10
                                ? context.l10n.contactAdminMessageContract
                                : context.l10n.contactAdminMessageInaccessible,
                          );
                          final Uri whatsapp = Uri.parse(
                            "https://wa.me/6281364993863?text=$encodedMessage",
                          );
                          if (await canLaunchUrl(whatsapp)) {
                            launchUrl(whatsapp);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.message,
                              size: 16,
                            ), // Use simple icon for now
                            const SizedBox(width: 8),
                            Text(context.l10n.contactAdmin),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ).then((_) => _isDialogShowing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Default background for bottom part
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          // Check status logic
          if (homeProvider.status == HomeStatus.loaded &&
              homeProvider.employee != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkStatus(context, homeProvider.employee!.status);
            });
          }

          if (homeProvider.isLoading && homeProvider.employee == null) {
            return const Center(
              child: SpinKitThreeBounce(color: AppColors.primary, size: 50.0),
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

          return Stack(
            children: [
              // 1. Red Background Header (Fixed height)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 200, // Adjust height as needed for coverage
                child: Container(color: AppColors.primary),
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
                        // Profile Card (Header content)
                        // Removing the default Container behavior in ProfileCard to blend with our background
                        // We will adjust ProfileCard to be transparent or part of this flow
                        ProfileCard(
                          employee: homeProvider.employee,
                          notificationCount: homeProvider.notificationCount,
                        ),

                        // Points Card (Overlapping logic handled by negative transform or just stacking order if using Stack inside,
                        // but here in Column, we want it to 'float' over the transition.
                        // Since we have the red background behind, valid strategy is:
                        // Red background is fixed. Button content flows.
                        // We need the PointsCard to be partly on Red, partly on White.
                        // ProfileCard will take up some vertical space.
                        // We can add negative offset, or just structure it tightly.

                        // Let's add a Transform.translate to pull it up if needed, or rely on ProfileCard sizing.
                        // In V1, the card is significantly overlapping the bottom of the red area.
                        if (homeProvider.employee?.type == 'worker') ...[
                          Transform.translate(
                            offset: const Offset(0, -30), // Pull up to overlap
                            child: PointsCard(kpi: homeProvider.kpi),
                          ),
                          // No extra SizedBox needed because we pulled it up, but we might need to compensate for the space below if the next item is too close?
                          // Actually Translate doesn't affect layout flow size, so the space below remains "occupied" by the original position.
                          // So we might need to reduce the space *after* it or it will look like a gap.
                          const SizedBox(height: 0),
                        ] else ...[
                          const SizedBox(height: 20),
                        ],

                        // Menu Grid
                        // If PointsCard is present, we pulled it up -30.
                        // The gap below it (original layout space) still exists.
                        // So the menu grid will start 'normal'.
                        // Visual check will confirm spacing.
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: MenuGrid(
                            menus: homeProvider.menus,
                            notificationCount: homeProvider.notificationCount,
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
                          context.l10n.copyright(
                            DateTime.now().year.toString(),
                          ),
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
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
