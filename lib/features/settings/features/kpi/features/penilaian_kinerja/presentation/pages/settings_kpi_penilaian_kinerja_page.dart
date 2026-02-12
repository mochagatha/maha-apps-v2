import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../../../../core/utils/localization_extension.dart';
import '../../../../../../../../shared/theme/app_theme.dart';
import '../../../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../../../shared/widgets/success_dialog.dart';
import '../providers/penilaian_kinerja_provider.dart';

/// Performance Assessment Configuration Page
///
/// Allows users to configure performance assessment settings including:
/// - Kehadiran (Attendance) settings
/// - Penilaian Atasan (Supervisor Assessment) settings
/// - Rencana Kerja (Work Plan) with position points
class SettingsKpiPenilaianKinerjaPage extends StatefulWidget {
  const SettingsKpiPenilaianKinerjaPage({super.key});

  @override
  State<SettingsKpiPenilaianKinerjaPage> createState() => _SettingsKpiPenilaianKinerjaPageState();
}

class _SettingsKpiPenilaianKinerjaPageState extends State<SettingsKpiPenilaianKinerjaPage> {
  // Controllers for Kehadiran (Attendance)
  final TextEditingController _maksimalPointAbsensiController = TextEditingController();
  final TextEditingController _terlambatController = TextEditingController();
  final TextEditingController _tidakAbsenPulangController = TextEditingController();
  final TextEditingController _sakitController = TextEditingController();
  final TextEditingController _manasikMasukController = TextEditingController();

  // Controller for Penilaian Atasan
  final TextEditingController _maksimalPointAtasanController = TextEditingController();

  // Controllers for Work Plan - stored in a list
  final List<Map<String, TextEditingController>> _workPlanControllers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    final provider = context.read<PenilaianKinerjaProvider>();

    // Initialize Kehadiran controllers
    _maksimalPointAbsensiController.text = provider.maksimalPointAbsensi.toString();
    _terlambatController.text = provider.terlambat.toString();
    _tidakAbsenPulangController.text = provider.tidakAbsenPulang.toString();
    _sakitController.text = provider.sakit.toString();
    _manasikMasukController.text = provider.manasikMasuk.toString();

    // Initialize Penilaian Atasan controller
    _maksimalPointAtasanController.text = provider.maksimalPointAtasan.toString();

    // Initialize Work Plan controllers
    _workPlanControllers.clear();
    for (var position in provider.workPlanPositions) {
      _workPlanControllers.add({
        'minPoint': TextEditingController(text: position.minPoint.toString()),
        'maxPoint': TextEditingController(text: position.maxPoint.toString()),
      });
    }
  }

  @override
  void dispose() {
    _maksimalPointAbsensiController.dispose();
    _terlambatController.dispose();
    _tidakAbsenPulangController.dispose();
    _sakitController.dispose();
    _manasikMasukController.dispose();
    _maksimalPointAtasanController.dispose();

    for (var controllers in _workPlanControllers) {
      controllers['minPoint']?.dispose();
      controllers['maxPoint']?.dispose();
    }

    super.dispose();
  }

  void _handleReset() {
    final provider = context.read<PenilaianKinerjaProvider>();
    provider.reset();
    _initializeControllers();
  }

  void _handleApply() {
    ConfirmDialog.show(
      context,
      title: context.l10n.performanceAssessmentDialogConfirmTitle,
      message: context.l10n.performanceAssessmentDialogConfirmMessage,
      onConfirm: () async {
        final provider = context.read<PenilaianKinerjaProvider>();

        // Update Kehadiran values
        provider.updateMaksimalPointAbsensi(
          int.tryParse(_maksimalPointAbsensiController.text) ?? 20,
        );
        provider.updateTerlambat(int.tryParse(_terlambatController.text) ?? 50);
        provider.updateTidakAbsenPulang(int.tryParse(_tidakAbsenPulangController.text) ?? 50);
        provider.updateSakit(int.tryParse(_sakitController.text) ?? 100);
        provider.updateManasikMasuk(int.tryParse(_manasikMasukController.text) ?? 100);

        // Update Penilaian Atasan value
        provider.updateMaksimalPointAtasan(int.tryParse(_maksimalPointAtasanController.text) ?? 20);

        // Update Work Plan values
        for (int i = 0; i < _workPlanControllers.length; i++) {
          final minPoint = int.tryParse(_workPlanControllers[i]['minPoint']!.text);
          final maxPoint = int.tryParse(_workPlanControllers[i]['maxPoint']!.text);
          provider.updateWorkPlanPosition(i, minPoint: minPoint, maxPoint: maxPoint);
        }

        // Apply changes
        final success = await provider.applyChanges();

        if (success && mounted) {
          SuccessDialog.show(
            context,
            title: context.l10n.performanceAssessmentDialogSuccessTitle,
            message: context.l10n.performanceAssessmentDialogSuccessMessage,
          );
        } else if (mounted && provider.errorMessage != null) {
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
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: context.l10n.performanceAssessmentTitle,
      ),
      body: Consumer<PenilaianKinerjaProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Kehadiran Section
                _buildSection(
                  title: context.l10n.performanceAssessmentKehadiran,
                  children: [
                    _buildPercentageRow(
                      cardColor: Color(0xFFCCFBD3),
                      operation: "X",
                      label: context.l10n.performanceAssessmentMaksimalPointAbsensi,
                      formula: context.l10n.performanceAssessmentTargetPointX,
                      controller: _maksimalPointAbsensiController,
                    ),
                    SizedBox(height: 4),
                    _buildPercentageRow(
                      cardColor: Color(0xFFFDE0D1),
                      label: context.l10n.performanceAssessmentTerlambat,
                      formula: context.l10n.performanceAssessmentPoinAbsensiHarian,
                      controller: _terlambatController,
                    ),
                    SizedBox(height: 4),
                    _buildPercentageRow(
                      cardColor: Color(0xFFFDE0D1),
                      label: context.l10n.performanceAssessmentTidakAbsenPulang,
                      formula: context.l10n.performanceAssessmentPoinAbsensiHarian,
                      controller: _tidakAbsenPulangController,
                    ),
                    SizedBox(height: 4),
                    _buildPercentageRow(
                      cardColor: Color(0xFFFDE0D1),
                      label: context.l10n.performanceAssessmentSakit,
                      formula: context.l10n.performanceAssessmentPoinAbsensiHarian,
                      controller: _sakitController,
                    ),
                    SizedBox(height: 4),
                    _buildPercentageRow(
                      cardColor: Color(0xFFFDE0D1),
                      label: context.l10n.performanceAssessmentManasikMasuk,
                      formula: context.l10n.performanceAssessmentPoinAbsensiHarian,
                      controller: _manasikMasukController,
                    ),
                  ],
                ),

                // Penilaian Atasan Section
                _buildSection(
                  title: context.l10n.performanceAssessmentPenilaianAtasan,
                  children: [
                    _buildPercentageRow(
                      cardColor: Color(0xFFE9F6FF),
                      label: context.l10n.performanceAssessmentMaksimalPointAtasan,
                      formula: context.l10n.performanceAssessmentTargetPointX,
                      controller: _maksimalPointAtasanController,
                    ),
                  ],
                ),

                // Rencana Kerja Section
                _buildSection(
                  title: context.l10n.performanceAssessmentRencanaKerja,
                  children: [
                    _buildWorkPlanTable(provider),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<PenilaianKinerjaProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
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
                        context.l10n.performanceAssessmentButtonReset,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
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
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              context.l10n.performanceAssessmentButtonApply,
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

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildPercentageRow({
    required String label,
    required String formula,
    Color? cardColor,
    String operation = '-',
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Card(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            '=',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Card(
              color: AppColors.neutral1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  formula,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(operation, style: TextStyle(fontSize: 13)),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                ),
                suffix: const Text('%', style: TextStyle(fontSize: 12)),
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkPlanTable(PenilaianKinerjaProvider provider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Table Header
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  context.l10n.performanceAssessmentJabatan,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  context.l10n.performanceAssessmentMinPoint,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  context.l10n.performanceAssessmentMaxPoint,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Table Rows
          ...List.generate(provider.workPlanPositions.length, (index) {
            final position = provider.workPlanPositions[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      position.position,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _workPlanControllers[index]['minPoint'],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: _workPlanControllers[index]['maxPoint'],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
