import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../domain/entities/recruitment_menu_item.dart';
import '../providers/recruitment_provider.dart';
import '../widgets/recruitment_menu_card.dart';
import '../../utils/recruitment_menu_mapper.dart';

class RecruitmentPage extends StatefulWidget {
  const RecruitmentPage({super.key});

  @override
  State<RecruitmentPage> createState() => _RecruitmentPageState();
}

class _RecruitmentPageState extends State<RecruitmentPage> {
  @override
  void initState() {
    super.initState();
    // Load recruitment menus when page is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RecruitmentProvider>().loadRecruitmentMenus();
    });
  }

  Future<void> _onRefresh() async {
    await context.read<RecruitmentProvider>().refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.l10n.recruitmentTitle,
      ),
      body: Consumer<RecruitmentProvider>(
        builder: (context, provider, child) {
          // Loading state
          if (provider.isLoading && provider.menuItems.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: AppColors.primary, size: 50.0));
          }

          // Error state
          if (provider.hasError && provider.menuItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage ?? context.l10n.errorOccurred,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => provider.loadRecruitmentMenus(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (provider.menuItems.isEmpty) {
            return Center(
              child: Text(context.l10n.recruitmentEmpty, style: const TextStyle(fontSize: 16)),
            );
          }

          // Success state - display menu list
          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: provider.menuItems.length,
              itemBuilder: (context, index) {
                final menuItem = provider.menuItems[index];

                // Get localized label and route from mapper
                final localizedLabel = RecruitmentMenuMapper.getMenuLabel(context, menuItem.id);
                final route = RecruitmentMenuMapper.getRoute(menuItem.id);

                // Create a copy of menuItem with localized label (if we could, but better to just pass it or modifying the card? 
                // Since RecruitmentMenuCard takes menuItem, let's assume we can't easily modify menuItem itself as it should be immutable.
                // However, we can construct a new one.
                final displayItem = RecruitmentMenuItem(
                  id: menuItem.id,
                  label: localizedLabel,
                  icon: menuItem.icon,
                  route: menuItem.route, // Or use the one from mapper? Provider might return it. 
                  count: menuItem.count,
                );

                return RecruitmentMenuCard(
                  menuItem: displayItem,
                  onTap: () {
                    if (route != null) {
                      // Navigate using go_router
                      context.push(route);
                    } else {
                      // Show coming soon message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.l10n.featureComingSoonDynamic(displayItem.label))),
                      );
                    }
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
