import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../shared/theme/app_theme.dart';
import '../../../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/success_dialog.dart';
import '../providers/ubah_periode_surat_provider.dart';

/// Ubah Periode Surat Configuration Page
class SettingsKpiUbahPeriodeSuratPage extends StatefulWidget {
  const SettingsKpiUbahPeriodeSuratPage({super.key});

  @override
  State<SettingsKpiUbahPeriodeSuratPage> createState() => _SettingsKpiUbahPeriodeSuratPageState();
}

class _SettingsKpiUbahPeriodeSuratPageState extends State<SettingsKpiUbahPeriodeSuratPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<UbahPeriodeSuratProvider>();
      provider.loadPunishmentSetting();
    });
  }

  void _handleReset() {
    final provider = context.read<UbahPeriodeSuratProvider>();
    provider.resetForm();
  }

  void _handleApply() {
    final provider = context.read<UbahPeriodeSuratProvider>();

    // Show confirmation dialog
    ConfirmDialog.show(
      context,
      title: 'Konfirmasi',
      message:
          'Apakah anda yakin ingin mengubah Format Ubah periode Surat teguran & Peringatan ini ?',
      onConfirm: () async {
        // Apply changes
        final success = await provider.saveSetting();

        if (success && mounted) {
          // Show success dialog
          SuccessDialog.show(
            context,
            title: 'Berhasil!',
            message: 'Format telah berhasil\ndi Terapkan !',
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
        title: 'Ubah Periode Surat Teguran &\nSurat Peringatan',
      ),
      body: Consumer<UbahPeriodeSuratProvider>(
        builder: (context, provider, child) {
          if (provider.status == UbahPeriodeSuratStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Surat Teguran Section
                const Text(
                  'Surat Teguran',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),

                // Toggle Activation Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Aktifkan Otomatisasi Surat Teguran\ndan Surat Peringatan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            provider.toggleActivation(!provider.isActive);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: provider.isActive ? AppColors.primary : Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (provider.isActive) ...[
                                  Text(
                                    'On',
                                    style: const TextStyle(
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
                                    color: provider.isActive
                                        ? AppColors.primary
                                        : Colors.grey.shade400,
                                  ),
                                ),
                                if (!provider.isActive) ...[
                                  const SizedBox(width: 4),
                                  Text(
                                    'Off',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Description Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Surat Teguran dan Surat Peringatan akan muncul apabila karyawan polanya tidak sesuai dengan target yang ditentukan.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Automatic Period Card
                Card(
                  elevation: 0,
                  color: const Color(0xFFE8F5E9), // Light green
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Otomatis Surat Teguran &\nPeringatan',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Text(
                          '=',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: DropdownButton<int>(
                            value: provider.selectedMonths,
                            underline: const SizedBox(),
                            isDense: true,
                            items: List.generate(4, (index) => index + 1).map((months) {
                              return DropdownMenuItem(
                                value: months,
                                child: Text(
                                  '$months Bulan',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                provider.setSelectedMonths(value);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Loan Point Checkbox Card
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Checkbox(
                          value: provider.loanPoint,
                          activeColor: AppColors.primary,
                          onChanged: (value) {
                            if (value != null) {
                              provider.toggleLoanPoint(value);
                            }
                          },
                        ),
                        const Expanded(
                          child: Text(
                            'Aktifkan Hutang dan Kelebihan Poin',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
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
      bottomNavigationBar: Consumer<UbahPeriodeSuratProvider>(
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
                      onPressed: provider.status == UbahPeriodeSuratStatus.updating
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
                      onPressed: provider.status == UbahPeriodeSuratStatus.updating
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
                      child: provider.status == UbahPeriodeSuratStatus.updating
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
}
