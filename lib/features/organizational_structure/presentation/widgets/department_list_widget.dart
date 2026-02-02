import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../domain/entities/department_entity.dart';
import '../providers/organizational_structure_provider.dart';
import 'department_form_bottom_sheet.dart';
import 'empty_state_widget.dart';
import 'entity_card_widget.dart';

class DepartmentListWidget extends StatelessWidget {
  final List<DepartmentEntity> departments;
  final String typeRole;
  final String typeBranch;
  final VoidCallback onRefresh;

  const DepartmentListWidget({
    super.key,
    required this.departments,
    required this.typeRole,
    required this.typeBranch,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrganizationalStructureProvider>();

    if (provider.isLoading && departments.isEmpty) {
      return const Center(child: SpinKitThreeBounce(color: Colors.red));
    }

    if (departments.isEmpty) {
      return RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            EmptyStateWidget(
              title: 'Belum Ada List Data Departemen!',
              message: 'Jangan lupa untuk melihat List Data Departemen melalui aplikasi Maha!',
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
          itemCount: departments.length,
          itemBuilder: (context, index) {
            final department = departments[index];
            return Column(
              children: [
                EntityCardWidget(
                  title: department.departmentName,
                  onEdit: () => _showEditDialog(context, department),
                  onDelete: () => _handleDelete(context, department, provider),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, DepartmentEntity department) {
    final provider = context.read<OrganizationalStructureProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: DepartmentFormBottomSheet(
          isEdit: true,
          id: department.id,
          name: department.departmentName,
          typeRole: typeRole,
          typeBranch: typeBranch,
          onSuccess: onRefresh,
        ),
      ),
    );
  }

  void _handleDelete(
    BuildContext context,
    DepartmentEntity department,
    OrganizationalStructureProvider provider,
  ) {
    ConfirmDialog.show(
      context,
      title: 'Konfirmasi Hapus',
      message: 'Apakah Anda yakin ingin',
      messageActionText: 'menghapus departemen "${department.departmentName}"',
      onConfirm: () async {
        final success = await provider.deleteDepartmentData(department.id);

        if (context.mounted) {
          if (success) {
            SuccessDialog.show(
              context,
              message: 'Departemen "${department.departmentName}" berhasil dihapus',
              onConfirm: onRefresh,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(provider.errorMessage ?? 'Gagal menghapus departemen'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }
}
