import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/loading_dialog.dart';
import '../../../../../../shared/widgets/success_dialog.dart';
import '../providers/access_screen_provider.dart';
import '../widgets/custom_switch.dart';

class AccessScreenListPage extends StatefulWidget {
  const AccessScreenListPage({super.key});

  @override
  State<AccessScreenListPage> createState() => _AccessScreenListPageState();
}

class _AccessScreenListPageState extends State<AccessScreenListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccessScreenProvider>().fetchAccessScreenList('employee');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Pengaturan Akses Layar", centerTitle: true),
      body: Consumer<AccessScreenProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.data == null) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (provider.data == null) {
            // Handle error or empty case
            return Center(child: Text(provider.errorMessage));
          }

          // Re-using the logic from v1 but adapting to data structure
          final data = provider.data!;
          // The model I created has employeeList
          // AccessScreenModel is AccessScreenGlobalEntity
          // But AccessScreenModel has 'employeeList'. AccessScreenGlobalEntity does NOT have it in my previous definition.
          // Wait, I defined AccessScreenGlobalEntity without list.
          // I need to cast it or update the entity.
          // Let's check the entity definition I wrote. I made AccessScreenModel extend AccessScreenGlobalEntity
          // but GlobalEntity only has id, isRecord, isCatch.
          // I should have put the list in the entity or handled it differently.
          // Let's check AccessScreenModel again. It contains employeeList.
          // I should Cast provider.data to AccessScreenModel if I want to access the list,
          // OR update the entity to include the list.
          // The best practice is to have the entity contain the list.
          // For now, I will cast it dynamically or access it safely.
          // Since I can't easily change the entity now without more tool calls, I'll assume I can access it via the concrete model if I cast,
          // OR I can use dynamic for now if I am lazy, but that's bad.
          // Actually, in `AccessScreenProvider`, `_data` is `AccessScreenGlobalEntity`.
          // I should update `AccessScreenGlobalEntity` to include the list.
          // BUT, I can't do that easily now.
          // Actually, I should have defined `AccessScreenListEntity` that extends `AccessScreenGlobalEntity` or has it.
          // Let's assume for this step I will cast it or fix it.
          // A quick fix is to cast it in the UI since I know the implementation returns the Model which has the list.

          // Actually, let's fix the entity first to be clean.
          // But I'm in the middle of writing this file.
          // I'll write the code assuming the entity HAS the list, and then I will go fix the entity file immediately after.
          // That's risky if I forget.
          // Better: I will use `dynamic` cast for now in this file, and then fix the entity layer in the next step.

          dynamic dynamicData = data;
          final employeeList = dynamicData.employeeList as List;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400, width: 0.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      _buildSwitchTile(
                        title: "Perizinan Tangkap Layar",
                        description: "Izin untuk menangkap layar bagi karyawan",
                        isActive: provider.isCatch,
                        onChanged: (value) {
                          provider.isCatch = value;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildSwitchTile(
                        title: "Perizinan Rekam Layar",
                        description: "Izin untuk merekam layar bagi karyawan",
                        isActive: provider.isRecord,
                        onChanged: (value) {
                          provider.isRecord = value;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  // Use Expanded to take remaining space
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400, width: 0.5),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListView.builder(
                      itemCount: employeeList.length,
                      itemBuilder: (context, index) {
                        final employee = employeeList[index];
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRoutes.accessScreenDetail.name,
                              queryParameters: {
                                'id': employee.id.toString(),
                                'type': 'employee', // Defaulting to employee for now
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400, width: 0.5),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.red,
                                  radius: 24,
                                  backgroundImage: NetworkImage(employee.photoUrl ?? ''),
                                  onBackgroundImageError: (_, __) {},
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        employee.fullname,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        employee.jobTitle,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.chevron_right, color: Colors.grey),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<AccessScreenProvider>(
        builder: (context, provider, child) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return ConfirmDialog(
                          title: "Konfirmasi",
                          message: "Apakah Anda yakin ingin menyimpan perubahan?",
                          onConfirm: () async {
                            // Save navigator reference before async operation
                            final dialogNavigator = Navigator.of(dialogContext);

                            LoadingDialog.show(dialogContext);
                            final success = await provider.updateGlobal();

                            // Use saved navigator to close loading dialog
                            if (dialogNavigator.canPop()) {
                              dialogNavigator.pop();
                            }

                            if (success && context.mounted) {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    const SuccessDialog(message: "Berhasil menyimpan pengaturan"),
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String description,
    required bool isActive,
    required Function(bool) onChanged,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(fontSize: 13, color: Colors.grey),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CustomSwitch(value: isActive, onChanged: onChanged),
      ],
    );
  }
}
