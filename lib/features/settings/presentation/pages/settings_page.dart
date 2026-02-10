import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_item.dart';
import 'package:maha_apps_v2/features/settings/presentation/models/settings_menu_model.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/menu_config.dart';
import '../../../../core/providers/language_provider.dart';
import '../../../../core/router/route_paths.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../core/utils/menu_cache_helper.dart';
import '../../../home/presentation/providers/home_provider.dart';

import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/menu_item_card.dart';

/// Settings page displaying all available settings menu items
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
          // Get settings menus from hierarchical cache (children of PENGATURAN)
          final settingsMenus =
              homeProvider.hierarchicalMenus
                  .firstWhere(
                    (element) => element.code == "PENGATURAN",
                  )
                  .children ??
              [];

          // Map MenuItem to SettingsMenuItem
          final mappedMenus = settingsMenus.map((menuItem) {
            return SettingsMenuItem(
              id: menuItem.code,
              icon: _getIconPath(menuItem.code, menuItem.icon),
              text: menuItem.name,
              count: 0,
              route: _getRoutePath(menuItem.code),
            );
          }).toList();

          // Sort by order if available
          mappedMenus.sort((a, b) {
            final menuA = settingsMenus.firstWhere((m) => m.code == a.id);
            final menuB = settingsMenus.firstWhere((m) => m.code == b.id);
            return menuA.order.compareTo(menuB.order);
          });

          // Show loading if no menus yet
          if (mappedMenus.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          return RefreshIndicator(
            color: Colors.red,
            onRefresh: () async {
              // Refresh hierarchical menus
              await homeProvider.refreshHierarchicalMenus();
            },
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              children: [
                // Settings Menu Items
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: mappedMenus.length,
                  itemBuilder: (context, index) {
                    final menuItem = mappedMenus[index];
                    return MenuItemCard(
                      asset: menuItem.icon,
                      title: menuItem.text,
                      onTap: () {
                        if (menuItem.id == MenuConfig.pengaturanBahasa) {
                          _showLanguageDialog(context);
                        } else if (menuItem.route != null) {
                          context.push(menuItem.route!);
                        }
                      },
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Cache Management Section
                _buildCacheManagementSection(context),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Get icon path based on menu code
  String _getIconPath(String code, String? apiIcon) {
    // Map menu codes to local icon paths
    final iconMap = {
      'PENGATURAN/ABSENSI': 'assets/icons/settings/absensi.png',
      'PENGATURAN/FORMAT_DAN_DRAF': 'assets/icons/settings/format_dan_draf.png',
      'PENGATURAN/PENEMPATAN_KERJA': 'assets/images/icon/penempatan_kerja_icon.svg',
      'PENGATURAN/LIBUR': 'assets/images/icon/hari_libur.svg',
      'PENGATURAN/PENGATURAN_LEMBUR': 'assets/images/icon/lembur.svg',
      'PENGATURAN/TINDAKAN_KARYAWAN': 'assets/images/icon/tindakan_karyawan.svg',
      'PENGATURAN/AKSES_LAYAR': 'assets/images/icon/akses_layar.svg',
      'PENGATURAN/HAK_AKSES_MENU': 'assets/images/icon/hak_akses_menu.svg',
      'PENGATURAN/EMAIL': 'assets/icons/settings/email.png',
      'PENGATURAN/WHATSAPP': 'assets/icons/settings/whatsapp.png',
      'PENGATURAN/ALUR_OPERASIONAL': 'assets/icons/settings/alur_operasional.png',
      'PENGATURAN/PELCAKAN_JAM_KERJA': 'assets/images/icon/jam_kerja.svg',
      'PENGATURAN/STRUKTUR_ORGANISASI': 'assets/images/icon/struktur_organisasi.svg',
      'PENGATURAN/KPI': 'assets/images/icon/setting_kpi.svg',
      'PENGATURAN/BAHASA': 'assets/images/icon/setting_language.svg',
      'PENGATURAN/NOTIFIKASI': 'assets/icons/settings/notifikasi.png',
    };

    return iconMap[code] ?? 'assets/images/icon/default_menu.svg';
  }

  /// Get route path based on menu code
  String? _getRoutePath(String code) {
    // Map menu codes to routes
    final routeMap = {
      'PENGATURAN/ABSENSI': RoutePaths.settingsAbsensi,
      'PENGATURAN/FORMAT_DAN_DRAF': RoutePaths.settingsFormatDanDraf,
      'PENGATURAN/PENEMPATAN_KERJA': RoutePaths.settingsPenempatanKerja,
      'PENGATURAN/LIBUR': RoutePaths.settingsLibur,
      'PENGATURAN/PENGATURAN_LEMBUR': RoutePaths.settingsLembur,
      'PENGATURAN/TINDAKAN_KARYAWAN': RoutePaths.settingsTindakanKaryawan,
      'PENGATURAN/AKSES_LAYAR': RoutePaths.settingsAksesLayar,
      'PENGATURAN/HAK_AKSES_MENU': RoutePaths.employeeSelection,
      'PENGATURAN/EMAIL': RoutePaths.settingsEmail,
      'PENGATURAN/WHATSAPP': RoutePaths.settingsWhatsapp,
      'PENGATURAN/ALUR_OPERASIONAL': RoutePaths.settingsAlurOperasional,
      'PENGATURAN/PELCAKAN_JAM_KERJA': RoutePaths.settingsPelacakanJamKerja,
      'PENGATURAN/STRUKTUR_ORGANISASI': RoutePaths.organizationalStructure,
      'PENGATURAN/KPI': RoutePaths.settingsKpi,
      'PENGATURAN/BAHASA': RoutePaths.settingsBahasa,
      'PENGATURAN/NOTIFIKASI': RoutePaths.settingsNotifikasi,
    };

    return routeMap[code];
  }

  Widget _buildCacheManagementSection(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        final menuCount = homeProvider.hierarchicalMenus.length;
        final hasMenus = MenuCacheHelper.areMenusLoaded(context);

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.storage, color: Colors.grey.shade700, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Cache Management',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Cache Info
              _buildCacheInfoRow(
                icon: Icons.menu_book,
                label: 'Cached Menus',
                value: '$menuCount menus',
                color: hasMenus ? Colors.green : Colors.grey,
              ),
              const SizedBox(height: 8),
              _buildCacheInfoRow(
                icon: Icons.check_circle,
                label: 'Status',
                value: hasMenus ? 'Active' : 'Empty',
                color: hasMenus ? Colors.green : Colors.orange,
              ),

              const SizedBox(height: 16),

              // Refresh Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _refreshMenuCache(context),
                  icon: const Icon(Icons.refresh, size: 20),
                  label: const Text('Refresh Menu Cache'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCacheInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Text(
          '$label:',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }

  Future<void> _refreshMenuCache(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitThreeBounce(color: Colors.red, size: 30),
                SizedBox(height: 16),
                Text('Refreshing menu cache...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      // Refresh cache
      await MenuCacheHelper.refreshMenuCache(context);

      if (!mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Menu cache refreshed successfully!'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('Failed to refresh cache: $e')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showLanguageDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    context.l10n.selectLanguage, // "Pilih Bahasa"
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildLanguageOption(
                    context,
                    title: context.l10n.languageIndonesian,
                    flag: '🇮🇩',
                    isSelected: languageProvider.currentLocale.languageCode == 'id',
                    onTap: () {
                      languageProvider.changeLanguage(const Locale('id'));
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 12),
                  _buildLanguageOption(
                    context,
                    title: context.l10n.languageEnglish,
                    flag: '🇺🇸',
                    isSelected: languageProvider.currentLocale.languageCode == 'en',
                    onTap: () {
                      languageProvider.changeLanguage(const Locale('en'));
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String flag,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFF0F0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red : Colors.grey.shade300,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle_rounded, color: Colors.red),
          ],
        ),
      ),
    );
  }
}
