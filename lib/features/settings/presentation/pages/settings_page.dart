import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:maha_apps_v2/features/settings/domain/entities/settings_menu_item.dart';
import 'package:maha_apps_v2/features/settings/presentation/models/settings_menu_model.dart';

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

    final allMenus = SettingsMenuModel.getAllSettingsMenu();
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
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
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
            if (menuItem.route != null) {
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
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.grey.shade300,
                  offset: const Offset(3, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  menuItem.icon,
                  height: 40,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    menuItem.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
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
}
