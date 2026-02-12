import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../shared/theme/app_theme.dart';
import '../../../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/success_dialog.dart';
import '../providers/target_point_provider.dart';

/// Target Point Configuration Page
///
/// Allows users to configure target points based on total salary (Total Gaji).
/// Features:
/// - Information section explaining target points
/// - Form to input total salary
/// - Reset and Apply buttons
/// - Confirmation dialog before applying changes
/// - Success dialog after successful application
class SettingsKpiTargetPointPage extends StatefulWidget {
  const SettingsKpiTargetPointPage({super.key});

  @override
  State<SettingsKpiTargetPointPage> createState() => _SettingsKpiTargetPointPageState();
}

class _SettingsKpiTargetPointPageState extends State<SettingsKpiTargetPointPage> {
  final TextEditingController _totalGajiController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize controller with current value from provider and load data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TargetPointProvider>();
      // Load indicators from API
      provider.loadTargetPointIndicators().then((_) {
        // Update text controller with loaded value
        _totalGajiController.text = provider.totalGaji.toString();
      });
    });
  }

  @override
  void dispose() {
    _totalGajiController.dispose();
    super.dispose();
  }

  void _handleReset() {
    final provider = context.read<TargetPointProvider>();
    provider.reset();
    _totalGajiController.text = provider.totalGaji.toString();
  }

  void _handleApply() {
    // Show confirmation dialog
    ConfirmDialog.show(
      context,
      title: context.l10n.targetPointDialogConfirmTitle,
      message: context.l10n.targetPointDialogConfirmMessage,
      onConfirm: () async {
        final provider = context.read<TargetPointProvider>();

        // Update value from text field
        final newValue = int.tryParse(_totalGajiController.text.trim());
        if (newValue != null) {
          provider.updateTotalGaji(newValue);
        }

        // Apply changes
        final success = await provider.applyChanges();

        if (success && mounted) {
          // Show success dialog
          SuccessDialog.show(
            context,
            title: context.l10n.targetPointDialogSuccessTitle,
            message: context.l10n.targetPointDialogSuccessMessage,
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
        title: context.l10n.targetPointTitle,
      ),
      body: Consumer<TargetPointProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Information Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.targetPointTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          context.l10n.targetPointInfoText,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Form Section
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.targetPointTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Total Gaji Field
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: AppColors.neutral3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                context.l10n.targetPointTotalGaji,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: _totalGajiController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Spacer to push buttons to bottom
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<TargetPointProvider>(
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
                      onPressed: provider.isLoading ? null : _handleReset,
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
                      child: Text(
                        context.l10n.targetPointButtonReset,
                        style: const TextStyle(
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
                      onPressed: provider.isLoading ? null : _handleApply,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 0,
                      ),
                      child: provider.isLoading
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
                          : Text(
                              context.l10n.targetPointButtonApply,
                              style: const TextStyle(
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
