import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../shared/theme/app_theme.dart';
import '../../../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/success_dialog.dart';
import '../provider/aktivasi_point_provider.dart';

/// Activation Point Settings Page
class SettingsKpiAktivasiPoint extends StatefulWidget {
  const SettingsKpiAktivasiPoint({super.key});

  @override
  State<SettingsKpiAktivasiPoint> createState() => _SettingsKpiAktivasiPointState();
}

class _SettingsKpiAktivasiPointState extends State<SettingsKpiAktivasiPoint> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AktivasiPointProvider>();
      provider.loadActivationSettings();
    });
  }

  void _handleReset() {
    final provider = context.read<AktivasiPointProvider>();
    provider.resetForm();
  }

  void _handleApply() {
    final provider = context.read<AktivasiPointProvider>();

    // Show confirmation dialog
    ConfirmDialog.show(
      context,
      title: 'Maaf, Sebelumnya...',
      message: 'Apakah anda yakin ingin menyimpan Pengaturan Aktivasi Poin ini ?',
      onConfirm: () async {
        // Apply changes
        final success = await provider.saveSettings();

        if (success && mounted) {
          // Show success dialog
          SuccessDialog.show(
            context,
            title: 'Berhasil!',
            message: 'Pengaturan Aktivasi Poin telah berhasil di Simpan !',
          );
        } else if (mounted && provider.errorMessage != null) {
          // Show error if any
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral2,
      appBar: CustomAppBar(
        title: 'Pengaturan Aktivasi Point',
      ),
      body: Consumer<AktivasiPointProvider>(
        builder: (context, provider, child) {
          if (provider.status == AktivasiPointStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Section
                const Text(
                  'Info',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Info Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Pengaturan Aktivasi Point yang merupakan fitur otomatis point digunakan oleh karyawan berupa akumulasi penambahan / pengurangan pada karyawan pada periode tertentu',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Activation Point Settings Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with toggle
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Pengaturan Aktivasi Point Karyawan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            _buildCustomToggle(
                              value: provider.isMainActivationEnabled,
                              onChanged: (value) {
                                provider.toggleMainActivation(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Divider(height: 1),
                        const SizedBox(height: 16),

                        // Header text
                        const Text(
                          'Aktivasi Poin',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Aktifkan Poin Hari Karyawan',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Search field
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search, color: Colors.grey.shade500, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Cari Nama Karyawan',
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Employee list
                        ...provider.employees.map((employee) {
                          return _buildEmployeeItem(
                            employee: employee,
                            onToggle: (value) {
                              provider.toggleEmployeeActivation(employee.id, value);
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<AktivasiPointProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Reset Button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: provider.status == AktivasiPointStatus.updating
                          ? null
                          : _handleReset,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(
                            color: AppColors.primary,
                            width: 1.5,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Reset',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Apply Button
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: provider.status == AktivasiPointStatus.updating
                          ? null
                          : _handleApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),
                      child: provider.status == AktivasiPointStatus.updating
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Terapkan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Build custom toggle switch
  Widget _buildCustomToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: value ? AppColors.primary : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value) ...[
              const Text(
                'On',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
            ],
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(
                Icons.check,
                size: 16,
                color: value ? AppColors.primary : Colors.grey.shade400,
              ),
            ),
            if (!value) ...[
              const SizedBox(width: 4),
              const Text(
                'Off',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build employee list item
  Widget _buildEmployeeItem({
    required EmployeeActivation employee,
    required ValueChanged<bool> onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                employee.name.substring(0, 1).toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Name and job title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  employee.jobTitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          // Toggle
          _buildCustomToggle(
            value: employee.isActive,
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}
