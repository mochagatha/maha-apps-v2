import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/job_title_entity.dart';
import '../providers/organizational_structure_provider.dart';
import 'job_title_form_bottom_sheet.dart';

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
    final provider = context.watch<OrganizationalStructureProvider>();

    if (provider.isLoading && jobTitles.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Colors.red));
    }

    if (jobTitles.isEmpty) {
      return RefreshIndicator(
        color: Colors.red,
        onRefresh: () async {
          onRefresh();
        },
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/icon/data_aproval_kosong.svg', height: 175),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum Ada Daftar Data Jabatan!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jangan lupa untuk melihat Daftar Data Jabatan melalui aplikasi Maha!',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
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
                _buildJobTitleCard(context, jobTitle, provider),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobTitleCard(
    BuildContext context,
    JobTitleEntity jobTitle,
    OrganizationalStructureProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              jobTitle.name ?? '',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                child: Text('Hapus'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                _showEditDialog(context, jobTitle);
              } else if (value == 'delete') {
                _showDeleteConfirmation(context, jobTitle, provider);
              }
            },
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, JobTitleEntity jobTitle) {
    final provider = context.read<OrganizationalStructureProvider>();
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

  void _showDeleteConfirmation(
    BuildContext context,
    JobTitleEntity jobTitle,
    OrganizationalStructureProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text('Apakah Anda yakin ingin menghapus jabatan "${jobTitle.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                final success = await provider.deleteJobTitle(jobTitle.id ?? 0);

                if (context.mounted) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Jabatan berhasil dihapus'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    onRefresh();
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
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }
}
