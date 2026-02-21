import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/utils/constants.dart';
import 'package:maha_apps_v2/features/archive/presentation/widgets/archive_menu_item.dart';
import 'package:provider/provider.dart';

import '../config/archive_menu_registry.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../../../core/config/sub_menu_config.dart';

/// Settings page displaying all available settings menu items
/// Uses centralized configuration for maintainability and l10n support
class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.menuArsip),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          // Get settings menus from hierarchical cache
          final archiveParent = homeProvider.hierarchicalMenus.firstWhere(
            (element) => element.code == AppConstants.menu.arsip,
            orElse: () => homeProvider.hierarchicalMenus.first,
          );

          final archiveMenus = archiveParent.children ?? [];

          // Show loading if no menus yet
          if (archiveMenus.isEmpty) {
            return const Center(
              child: SpinKitThreeBounce(color: Colors.red),
            );
          }

          // Filter only menus that have configuration in registry
          final validMenus = archiveMenus
              .where((menu) => ArchiveMenuRegistry.hasConfig(menu.code))
              .toList();

          // Sort by order from registry
          validMenus.sort((a, b) {
            final configA = ArchiveMenuRegistry.getConfig(a.code);
            final configB = ArchiveMenuRegistry.getConfig(b.code);
            return (configA?.order ?? 0).compareTo(configB?.order ?? 0);
          });

          return RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              await homeProvider.refreshHierarchicalMenus();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              children: [
                // Settings Menu Items
                ...validMenus.map((menuItem) {
                  final config = ArchiveMenuRegistry.getConfig(menuItem.code);
                  if (config == null) return const SizedBox.shrink();

                  // Get localized title using the titleKey from config
                  final localizedTitle = _getLocalizedTitle(context, config.titleKey);

                  return ArchiveMenuItem(
                    iconPath: config.iconPath,
                    title: localizedTitle,
                    onTap: () => _handleMenuTap(context, menuItem.code, config),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Get localized title for menu using l10n
  String _getLocalizedTitle(BuildContext context, String titleKey) {
    // Use reflection-like approach to get the localized string
    // This maps the titleKey to the actual l10n getter
    final l10n = context.l10n;

    switch (titleKey) {
      case 'arsipRegistrasi':
        return 'Regiastrasi';
      case 'arsipPernyataan':
        return 'Pernyataan';
      case 'arsipPerjanjian':
        return 'Perjanjian';
      default:
        return titleKey; // Fallback to key if not found
    }
  }

  /// Handle menu item tap with proper navigation or custom action
  void _handleMenuTap(
    BuildContext context,
    String menuCode,
    SubMenuConfig config,
  ) {
    // Check if menu has custom action (e.g., language dialog)
    // if (config.hasCustomAction) {
    //   if (menuCode == config.code) {
    //     LanguageSelector.show(context);
    //   }
    //   return;
    // }

    // Navigate to route if available
    if (config.routePath != null) {
      context.push(config.routePath!, extra: config.extra);
    }
  }
}
