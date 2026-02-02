import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../../domain/entities/job_title_entity.dart';
import '../providers/job_title_provider.dart';
import 'job_title_form_bottom_sheet.dart';
import 'empty_state_widget.dart';
import 'entity_card_widget.dart';

class JobTitleListWidget extends StatelessWidget {
  final List<JobTitleEntity> jobTitles;
  final String typeRole;
  final String typeBranch;
  final VoidCallback onRefresh;

  const JobTitleListWidget({
    super.key,
    required this.jobTitles,
    required this.typeRole,
    required this.typeBranch,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<JobTitleProvider>();

    if (provider.isLoading && jobTitles.isEmpty) {
      return const Center(child: SpinKitThreeBounce(color: Colors.red));
    }

    if (jobTitles.isEmpty) {
      return RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            EmptyStateWidget(
              title: 'Belum Ada Daftar Data Jabatan!',
              message: 'Jangan lupa untuk melihat Daftar Data Jabatan melalui aplikasi Maha!',
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
          itemCount: jobTitles.length,
          itemBuilder: (context, index) {
            final jobTitle = jobTitles[index];
            return Column(
              children: [
                EntityCardWidget(
                  title: jobTitle.name ?? '',
                  onEdit: () => _showEditDialog(context, jobTitle),
                  onDelete: () => _handleDelete(context, jobTitle, provider),
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, JobTitleEntity jobTitle) {
    final provider = context.read<JobTitleProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: JobTitleFormBottomSheet(
          isEdit: true,
          id: jobTitle.id,
          name: jobTitle.name,
          typeRole: typeRole,
          typeBranch: typeBranch,
          onSuccess: onRefresh,
        ),
      ),
    );
  }

  void _handleDelete(
    BuildContext context,
    JobTitleEntity jobTitle,
    JobTitleProvider provider,
  ) {
    ConfirmDialog.show(
      context,
      child: Text('Apakah Anda yakin ingin menghapus jabatan "${jobTitle.name}"?'),
      onConfirm: () async {
        final success = await provider.deleteJobTitle(jobTitle.id ?? 0);

        if (context.mounted) {
          if (success) {
            SuccessDialog.show(
              context,
              message: 'Jabatan "${jobTitle.name}" berhasil dihapus',
              onConfirm: onRefresh,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(provider.errorMessage ?? 'Gagal menghapus jabatan'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
    );
  }
}
