import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
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
      appBar: const CustomAppBar(
        title: 'Rekrutmen',
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
                    provider.errorMessage ?? 'Terjadi kesalahan',
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
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          // Empty state
          if (provider.menuItems.isEmpty) {
            return const Center(
              child: Text('Tidak ada menu rekrutmen tersedia', style: TextStyle(fontSize: 16)),
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

                // Get route from mapper
                final route = RecruitmentMenuMapper.getRoute(menuItem.id);

                return RecruitmentMenuCard(
                  menuItem: menuItem,
                  onTap: () {
                    if (route != null) {
                      // Navigate using go_router
                      context.push(route);
                    } else {
                      // Show coming soon message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Fitur ${menuItem.label} akan segera hadir!')),
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
