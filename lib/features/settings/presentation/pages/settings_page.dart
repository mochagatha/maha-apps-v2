import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/config/settings_menu_registry.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../home/presentation/providers/home_provider.dart';
import '../../domain/entities/settings_menu_config.dart';
import '../widgets/language_selector.dart';
import '../widgets/settings_menu_item.dart' as settings;

/// Settings page displaying all available settings menu items
/// Uses centralized configuration for maintainability and l10n support
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.menuPengaturan),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          // Get settings menus from hierarchical cache
          final settingsParent = homeProvider.hierarchicalMenus.firstWhere(
            (element) => element.code == "PENGATURAN",
            orElse: () => homeProvider.hierarchicalMenus.first,
          );

          final settingsMenus = settingsParent.children ?? [];

          // Show loading if no menus yet
          if (settingsMenus.isEmpty) {
            return const Center(
              child: SpinKitThreeBounce(color: Colors.red),
            );
          }

          // Filter only menus that have configuration in registry
          final validMenus = settingsMenus
              .where((menu) => SettingsMenuRegistry.hasConfig(menu.code))
              .toList();

          // Sort by order from registry
          validMenus.sort((a, b) {
            final configA = SettingsMenuRegistry.getConfig(a.code);
            final configB = SettingsMenuRegistry.getConfig(b.code);
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
                  final config = SettingsMenuRegistry.getConfig(menuItem.code);
                  if (config == null) return const SizedBox.shrink();

                  // Get localized title using the titleKey from config
                  final localizedTitle = _getLocalizedTitle(context, config.titleKey);

                  return settings.SettingsMenuItem(
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
      case 'settingsAbsensi':
        return l10n.settingsAbsensi;
      case 'settingsFormatDanDraf':
        return l10n.settingsFormatDanDraf;
      case 'settingsPenempatanKerja':
        return l10n.settingsPenempatanKerja;
      case 'settingsLibur':
        return l10n.settingsLibur;
      case 'settingsLembur':
        return l10n.settingsLembur;
      case 'settingsTindakanKaryawan':
        return l10n.settingsTindakanKaryawan;
      case 'settingsAksesLayar':
        return l10n.settingsAksesLayar;
      case 'settingsHakAksesMenu':
        return l10n.settingsHakAksesMenu;
      case 'settingsEmail':
        return l10n.settingsEmail;
      case 'settingsWhatsapp':
        return l10n.settingsWhatsapp;
      case 'settingsAlurOperasional':
        return l10n.settingsAlurOperasional;
      case 'settingsPelacakanJamKerja':
        return l10n.settingsPelacakanJamKerja;
      case 'settingsStrukturOrganisasi':
        return l10n.settingsStrukturOrganisasi;
      case 'settingsKpi':
        return l10n.settingsKpi;
      case 'settingsBahasa':
        return l10n.settingsBahasa;
      case 'settingsNotifikasi':
        return l10n.settingsNotifikasi;
      default:
        return titleKey; // Fallback to key if not found
    }
  }

  /// Handle menu item tap with proper navigation or custom action
  void _handleMenuTap(
    BuildContext context,
    String menuCode,
    SettingsMenuConfig config,
  ) {
    // Check if menu has custom action (e.g., language dialog)
    if (config.hasCustomAction) {
      if (menuCode == config.code) {
        LanguageSelector.show(context);
      }
      return;
    }

    // Navigate to route if available
    if (config.routePath != null) {
      context.push(config.routePath!);
    }
  }
}
