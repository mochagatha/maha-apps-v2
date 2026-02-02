import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_item.dart';
import 'package:maha_apps_v2/features/settings/presentation/models/settings_menu_model.dart';
import 'package:provider/provider.dart';
import '../../../../core/config/menu_config.dart';
import '../../../../core/providers/language_provider.dart';
import '../../../../core/utils/localization_extension.dart';

import '../../../../shared/widgets/custom_app_bar.dart';

/// Settings page displaying all available settings menu items
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<SettingsMenuItem> _menuItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
    });

    // TODO: Fetch menu access from API based on user permissions
    // For now, use all menu items
    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final allMenus = SettingsMenuModel.getAllSettingsMenu(context);
    final defaultMenuIds = SettingsMenuModel.getDefaultMenuIds();

    // TODO: Filter based on actual user permissions from API
    // For now, show all menus
    final filteredMenus = allMenus.where((menu) {
      return defaultMenuIds.contains(menu.id);
    }).toList();

    setState(() {
      _menuItems = filteredMenus;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.menuPengaturan),
      body: _isLoading
          ? const Center(child: SpinKitThreeBounce(color: Colors.red))
          : RefreshIndicator(
              color: Colors.red,
              onRefresh: _fetchData,
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = _menuItems[index];
                  return _buildMenuItem(menuItem);
                },
              ),
            ),
    );
  }

  Widget _buildMenuItem(SettingsMenuItem menuItem) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (menuItem.id == MenuConfig.pengaturanBahasa) {
              _showLanguageDialog(context);
            } else if (menuItem.route != null) {
              context.push(menuItem.route!);
            }
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 8, color: Colors.grey.shade300, offset: const Offset(3, 3)),
              ],
            ),
            child: Row(
              children: [
                SvgPicture.asset(menuItem.icon, height: 40),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(menuItem.text, style: const TextStyle(fontWeight: FontWeight.w600)),
                ),
                const Icon(Icons.keyboard_arrow_right),
              ],
            ),
          ),
        ),
        if (menuItem.count > 0)
          Positioned(
            top: 5,
            right: 5,
            child: Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Text(
                '${menuItem.count}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
      ],
    );
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
