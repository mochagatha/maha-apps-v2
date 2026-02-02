import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/employment_level_entity.dart';
import '../providers/organizational_structure_provider.dart';
import 'employment_level_form_bottom_sheet.dart';

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
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }

    if (employmentLevels.isEmpty) {
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
                    SvgPicture.asset(
                      'assets/images/icon/data_aproval_kosong.svg',
                      height: 175,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Belum Ada List Data Tingkatan!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Jangan lupa untuk melihat List Data Tingkatan melalui aplikasi Maha!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
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
          itemCount: employmentLevels.length,
          itemBuilder: (context, index) {
            final employmentLevel = employmentLevels[index];
            return Column(
              children: [
                _buildEmploymentLevelCard(
                  context,
                  employmentLevel,
                  provider,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmploymentLevelCard(
    BuildContext context,
    EmploymentLevelEntity employmentLevel,
    OrganizationalStructureProvider provider,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              employmentLevel.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.blue),
            onPressed: () {
              _showEditDialog(context, employmentLevel);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmation(context, employmentLevel, provider);
            },
          ),
        ],
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

  void _showDeleteConfirmation(
    BuildContext context,
    EmploymentLevelEntity employmentLevel,
    OrganizationalStructureProvider provider,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Konfirmasi Hapus'),
          content: Text(
            'Apakah Anda yakin ingin menghapus tingkatan "${employmentLevel.name}"?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                
                final success = await provider.deleteEmploymentLevelData(employmentLevel.id);
                
                if (context.mounted) {
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tingkatan berhasil dihapus'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    onRefresh();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          provider.errorMessage ?? 'Gagal menghapus tingkatan',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
