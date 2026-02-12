import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';
import 'package:maha_apps_v2/features/settings/features/kpi/presentation/config/settings_kpi_menu_registry.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/sub_menu_config.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../home/presentation/providers/home_provider.dart';
import '../../../../presentation/widgets/settings_menu_item.dart';

/// Settings Absensi page displaying all available absensi submenu items
/// Uses centralized configuration for maintainability and l10n support
class SettingsKpiPage extends StatefulWidget {
  const SettingsKpiPage({super.key});

  @override
  State<SettingsKpiPage> createState() => _SettingsKpiPageState();
}

class _SettingsKpiPageState extends State<SettingsKpiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.settingsAbsensi),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          final settingsParent = homeProvider.hierarchicalMenus.firstWhere(
            (element) => element.code == "PENGATURAN",
          );

          final settingsKpiParent = settingsParent.children?.firstWhere(
            (element) => element.code == "PENGATURAN/KPI",
          );

          final menus = settingsKpiParent?.children ?? [];

          // Show loading if no menus yet
          if (menus.isEmpty) {
            return const Center(
              child: SpinKitThreeBounce(color: Colors.red),
            );
          }

          // Filter only menus that have configuration in registry
          final validMenus = menus
              .where((menu) => SettingsKpiMenuRegistry.hasConfig(menu.code))
              .toList();

          // Sort by order from registry
          validMenus.sort((a, b) {
            final configA = SettingsKpiMenuRegistry.getConfig(a.code);
            final configB = SettingsKpiMenuRegistry.getConfig(b.code);
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
                  final config = SettingsKpiMenuRegistry.getConfig(menuItem.code);
                  if (config == null) return const SizedBox.shrink();

                  // Get localized title using the titleKey from config
                  final localizedTitle = _getLocalizedTitle(context, config.titleKey);

                  return SettingsMenuItem(
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
    final l10n = context.l10n;

    switch (titleKey) {
      case 'settingsKpiTargetPoint':
        return l10n.settingsKpiTargetPoint;
      case 'settingsKpiPenilaianKinerja':
        return l10n.settingsKpiPenilaianKinerja;
      case 'settingsKpiUbahPeriodeSurat':
        return l10n.settingsKpiUbahPeriodeSurat;
      case 'settingsKpiPengaturanAktivasiPoint':
        return l10n.settingsKpiPengaturanAktivasiPoint;
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
    // Navigate to route if available
    if (config.routePath != null) {
      context.push(config.routePath!);
    }
  }
}
