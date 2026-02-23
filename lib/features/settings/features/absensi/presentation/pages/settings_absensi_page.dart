import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/config/sub_menu_config.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../home/presentation/providers/home_provider.dart';
import '../../../../presentation/widgets/settings_menu_item.dart';
import '../config/settings_absensi_menu_registry.dart';

/// Settings Absensi page displaying all available absensi submenu items
/// Uses centralized configuration for maintainability and l10n support
class SettingsAbsensiPage extends StatefulWidget {
  const SettingsAbsensiPage({super.key});

  @override
  State<SettingsAbsensiPage> createState() => _SettingsAbsensiPageState();
}

class _SettingsAbsensiPageState extends State<SettingsAbsensiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.settingsAbsensi),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          // Get settings menus from hierarchical cache
          final settingsParent = homeProvider.hierarchicalMenus.firstWhere(
            (element) => element.code == "PENGATURAN",
          );

          final settingsAbsensiParent = settingsParent.children?.firstWhere(
            (element) => element.code == "PENGATURAN/ABSENSI",
          );

          final settingsMenus = settingsAbsensiParent?.children ?? [];

          // Show loading if no menus yet
          if (settingsMenus.isEmpty) {
            return const Center(
              child: SpinKitThreeBounce(color: Colors.red),
            );
          }

          // Filter only menus that have configuration in registry
          final validMenus = settingsMenus
              .where((menu) => SettingsAbsensiMenuRegistry.hasConfig(menu.code))
              .toList();

          // Sort by order from registry
          validMenus.sort((a, b) {
            final configA = SettingsAbsensiMenuRegistry.getConfig(a.code);
            final configB = SettingsAbsensiMenuRegistry.getConfig(b.code);
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
                  final config = SettingsAbsensiMenuRegistry.getConfig(menuItem.code);
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
    // Use reflection-like approach to get the localized string
    // This maps the titleKey to the actual l10n getter
    final l10n = context.l10n;

    switch (titleKey) {
      case 'settingsAbsensiPenempatanKerja':
        return l10n.settingsAbsensiPenempatanKerja;
      case 'settingsAbsensiZonasi':
        return l10n.settingsAbsensiZonasi;
      case 'settingsAbsensiJamKerja':
        return l10n.settingsAbsensiJamKerja;
      case 'settingsAbsensiKaryawan':
        return l10n.settingsAbsensiKaryawan;
      case 'settingsAbsensiPekerjaHarian':
        return l10n.settingsAbsensiPekerjaHarian;
      case 'settingsAbsensiHariLiburCutiBersama':
        return l10n.settingsAbsensiHariLiburCutiBersama;
      case 'settingsAbsensiLembur':
        return l10n.settingsAbsensiLembur;
      case 'settingsAbsensiAbsenDimanaSaja':
        return l10n.settingsAbsensiAbsenDimanaSaja;
      case 'settingsAbsensiPerbaikanKehadiran':
        return l10n.settingsAbsensiPerbaikanKehadiran;
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
