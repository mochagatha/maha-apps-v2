import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../shared/theme/app_theme.dart';
import '../../../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/success_dialog.dart';
import '../provider/employee_kpi_detail_provider.dart';

/// Detail page for updating a specific employee's KPI activation point setting
class SettingsKpiAktivasiPointDetailPage extends StatefulWidget {
  final int employeeId;

  const SettingsKpiAktivasiPointDetailPage({
    super.key,
    required this.employeeId,
  });

  @override
  State<SettingsKpiAktivasiPointDetailPage> createState() =>
      _SettingsKpiAktivasiPointDetailPageState();
}

class _SettingsKpiAktivasiPointDetailPageState extends State<SettingsKpiAktivasiPointDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeKpiDetailProvider>().loadEmployee(widget.employeeId);
    });
  }

  void _handleSave() {
    final provider = context.read<EmployeeKpiDetailProvider>();
    ConfirmDialog.show(
      context,
      title: 'Maaf, Sebelumnya...',
      message: 'Apakah anda yakin ingin menyimpan Pengaturan Aktivasi Poin Perorangan ini ?',
      onConfirm: () async {
        final success = await provider.save(widget.employeeId);

        if (!mounted) return;

        if (success) {
          SuccessDialog.show(
            context,
            title: 'Berhasil!',
            message: 'Pengaturan Aktivasi Poin Perorangan telah berhasil di Simpan !',
          );
        } else if (provider.errorMessage != null) {
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
      body: Consumer<EmployeeKpiDetailProvider>(
        builder: (context, provider, child) {
          if (provider.status == EmployeeKpiDetailStatus.loading ||
              provider.status == EmployeeKpiDetailStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.status == EmployeeKpiDetailStatus.error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errorMessage ?? 'Terjadi kesalahan',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadEmployee(widget.employeeId),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          final employee = provider.employee;
          if (employee == null) return const SizedBox.shrink();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Employee info card
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
                        const Text(
                          'Karyawan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Photo / avatar
                            _buildAvatar(employee.photoUrl, employee.fullname),
                            const SizedBox(width: 12),
                            // Info
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    employee.fullname,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  _buildInfoRow(
                                    Icons.badge_outlined,
                                    employee.nik,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildInfoRow(
                                    Icons.circle_outlined,
                                    employee.statusLabel,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildInfoRow(
                                    Icons.work_outline,
                                    employee.jobTitle,
                                  ),
                                  const SizedBox(height: 4),
                                  _buildInfoRow(
                                    Icons.account_balance_outlined,
                                    employee.departmentName,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Aktivasi Poin card
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
                        const Text(
                          'Aktivasi Poin',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Aktifkan Point Karyawan',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade700,
                                ),
                              ),
                            ),
                            _buildCustomToggle(
                              value: provider.isKpiActive,
                              onChanged: provider.toggleKpiActive,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<EmployeeKpiDetailProvider>(
        builder: (context, provider, child) {
          final isUpdating = provider.status == EmployeeKpiDetailStatus.updating;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: isUpdating ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 0,
                ),
                child: isUpdating
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Simpan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvatar(String? photoUrl, String name) {
    if (photoUrl != null && photoUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: Image.network(
          photoUrl,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildInitialsAvatar(name),
        ),
      );
    }
    return _buildInitialsAvatar(name);
  }

  Widget _buildInitialsAvatar(String name) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey.shade600),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomToggle({
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          color: value ? AppColors.primary.withOpacity(0.2) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: value ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value) ...[
              const SizedBox(width: 8),
              const Text(
                'On',
                style: TextStyle(
                  color: AppColors.primary,
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
                color: value ? AppColors.primary : Colors.white,
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
                color: value ? Colors.white : Colors.grey.shade700,
              ),
            ),
            if (!value) ...[
              const SizedBox(width: 4),
              Text(
                'Off',
                style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
            ],
          ],
        ),
      ),
    );
  }
}
