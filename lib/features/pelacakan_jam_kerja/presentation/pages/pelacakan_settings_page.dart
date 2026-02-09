import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/custom_elevated_button.dart';
import '../../../../shared/widgets/loading_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../../../shared/widgets/error_dialog.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../providers/pelacakan_provider.dart';
import '../widgets/employee_tracking_item.dart';

class PelacakanSettingsPage extends StatefulWidget {
  final String employeeType;

  const PelacakanSettingsPage({
    super.key,
    required this.employeeType,
  });

  @override
  State<PelacakanSettingsPage> createState() => _PelacakanSettingsPageState();
}

class _PelacakanSettingsPageState extends State<PelacakanSettingsPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PelacakanProvider>().loadTrackingData(widget.employeeType);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String get _title {
    return widget.employeeType == 'karyawan'
        ? 'Pengaturan Pelacakan Jam Kerja'
        : 'Pengaturan Pelacakan Pekerja Harian';
  }

  String get _subtitle {
    return widget.employeeType == 'karyawan' ? 'Karyawan' : 'Pekerja Harian';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: _title),
      body: Consumer<PelacakanProvider>(
        builder: (context, provider, child) {
          if (provider.status == PelacakanStatus.loading) {
            return Center(
              child: SpinKitThreeBounce(
                color: AppColors.primary,
                size: 24,
              ),
            );
          }

          // if (provider.status == PelacakanStatus.error) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(
          //           provider.errorMessage ?? 'Terjadi kesalahan',
          //           textAlign: TextAlign.center,
          //         ),
          //         const SizedBox(height: 16),
          //         ElevatedButton(
          //           onPressed: _loadData,
          //           child: const Text('Coba Lagi'),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Global Settings Section
                      Text(
                        'Pengaturan Pelacakan Jam Kerja Keseluruhan ($_subtitle)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Pelacakan Jam Kerja',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Aktifkan Pelacakan Jam Kerja $_subtitle',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: provider.isGlobalEnabled,
                            onChanged: (value) {
                              provider.toggleGlobalTracking(value);
                            },
                            activeColor: AppColors.primary,
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Individual Settings Section
                      Text(
                        'Pengaturan Pelacakan Jam Kerja Perorangan ($_subtitle)',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Search Box
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          provider.filterEmployees(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari ${_subtitle} Disini',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade400,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade400,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    _searchController.clear();
                                    provider.filterEmployees('');
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Employee List
                      if (provider.filteredEmployees.isEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              'Tidak ada $_subtitle ditemukan',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ),
                        )
                      else
                        ...provider.filteredEmployees.map((employee) {
                          return EmployeeTrackingItem(
                            employee: employee,
                            onToggle: (value) {
                              provider.toggleEmployeeTracking(employee.id, value);
                            },
                          );
                        }),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Consumer<PelacakanProvider>(
            builder: (context, provider, child) {
              return CustomElevatedButton(
                onPressed: () => _handleSave(context),
                loading: provider.isSaving,
                child: const Text('Simpan'),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final provider = context.read<PelacakanProvider>();

    // Show confirmation dialog
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        message: 'Apakah anda yakin ingin menyimpan Pengaturan Pelacakan Jam Kerja ini',
        onConfirm: () async {
          // Show loading
          if (!context.mounted) return;
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const LoadingDialog(
              message: 'Menyimpan pengaturan...',
            ),
          );

          // Save settings
          final success = await provider.saveSettings();

          // Close loading
          if (!context.mounted) return;
          Navigator.pop(context);

          if (success) {
            // Show success dialog
            showDialog(
              context: context,
              builder: (context) => SuccessDialog(
                message: 'Pengaturan Pelacakan Jam Kerja telah berhasil di',
                messageActionText: 'Simpan',
                onConfirm: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else {
            // Show error dialog
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(
                message: provider.errorMessage ?? 'Gagal menyimpan pengaturan',
              ),
            );
          }
        },
      ),
    );
  }
}
