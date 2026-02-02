import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../domain/entities/employment_level_entity.dart';
import '../providers/organizational_structure_provider.dart';
import 'employment_level_form_bottom_sheet.dart';
import 'empty_state_widget.dart';
import 'entity_card_widget.dart';

class EmploymentLevelListWidget extends StatelessWidget {
  final List<EmploymentLevelEntity> employmentLevels;
  final String typeRole;
  final VoidCallback onRefresh;

  const EmploymentLevelListWidget({
    super.key,
    required this.employmentLevels,
    required this.typeRole,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrganizationalStructureProvider>();

    if (provider.isLoading && employmentLevels.isEmpty) {
      return const Center(child: SpinKitThreeBounce(color: Colors.red));
    }

    if (employmentLevels.isEmpty) {
      return RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            EmptyStateWidget(
              title: 'Belum Ada List Data Tingkatan!',
              message: 'Jangan lupa untuk melihat List Data Tingkatan melalui aplikasi Maha!',
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          onRefresh();
        },
        child: ListView.builder(
          itemCount: employmentLevels.length,
          itemBuilder: (context, index) {
            final employmentLevel = employmentLevels[index];
            return Column(
              children: [
                EntityCardWidget(
                  title: employmentLevel.name,
                  onEdit: () => _showEditDialog(context, employmentLevel),
                  onDelete: () => _handleDelete(context, employmentLevel, provider),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, EmploymentLevelEntity employmentLevel) {
    final provider = context.read<OrganizationalStructureProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: EmploymentLevelFormBottomSheet(
          isEdit: true,
          id: employmentLevel.id,
          name: employmentLevel.name,
          typeRole: typeRole,
          onSuccess: onRefresh,
        ),
      ),
    );
  }

  void _handleDelete(
    BuildContext context,
    EmploymentLevelEntity employmentLevel,
    OrganizationalStructureProvider provider,
  ) {
    ConfirmDialog.show(
      context,
      title: 'Konfirmasi Hapus',
      message: 'Apakah Anda yakin ingin',
      messageActionText: 'menghapus tingkatan "${employmentLevel.name}"',
      onConfirm: () async {
        final success = await provider.deleteEmploymentLevelData(employmentLevel.id);

        if (context.mounted) {
          if (success) {
            SuccessDialog.show(
              context,
              message: 'Tingkatan "${employmentLevel.name}" berhasil dihapus',
              onConfirm: onRefresh,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(provider.errorMessage ?? 'Gagal menghapus tingkatan'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }
}
