import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/widgets/custom_app_bar.dart';
import '../../providers/organizational_structure_provider.dart';
import '../widgets/job_title_form_bottom_sheet.dart';

class JobTitleOfficeWorkerPage extends StatefulWidget {
  const JobTitleOfficeWorkerPage({super.key});

  @override
  State<JobTitleOfficeWorkerPage> createState() => _JobTitleOfficeWorkerPageState();
}

class _JobTitleOfficeWorkerPageState extends State<JobTitleOfficeWorkerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<OrganizationalStructureProvider>();
    await provider.loadJobTitles(typeRole: 'worker', typeBranch: 'office');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Data Jabatan',
      ),
      body: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }

          if (provider.errorMessage != null) {
            return _buildErrorState(provider.errorMessage!);
          }

          final jobTitles = provider.jobTitles;

          if (jobTitles.isEmpty) {
            return _buildEmptyState();
          }

          return _buildJobTitleList(jobTitles);
        },
      ),
      bottomNavigationBar: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const SizedBox.shrink();
          }

          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SafeArea(
              child: ElevatedButton(
                onPressed: () => _showAddJobTitleDialog(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Tambah Jabatan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/icon/data_aproval_kosong.svg',
                  height: 175,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Belum Ada Daftar Data Jabatan!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Jangan lupa untuk melihat Daftar Data Jabatan melalui aplikasi Maha!',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobTitleList(List<dynamic> jobTitles) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: jobTitles.length,
        itemBuilder: (context, index) {
          final jobTitle = jobTitles[index];
          return _buildJobTitleItem(jobTitle);
        },
      ),
    );
  }

  Widget _buildJobTitleItem(dynamic jobTitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey.shade400,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              jobTitle.name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'edit',
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                onTap: () => _showEditJobTitleDialog(jobTitle),
                child: const Text('Edit'),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                onTap: () => _confirmDelete(jobTitle),
                child: const Text('Hapus'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showAddJobTitleDialog() {
    final provider = context.read<OrganizationalStructureProvider>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: const JobTitleFormBottomSheet(
          isEdit: false,
          typeRole: 'worker',
          typeBranch: 'office',
        ),
      ),
    );
  }

  void _showEditJobTitleDialog(dynamic jobTitle) {
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
          typeRole: 'worker',
          typeBranch: 'office',
          id: jobTitle.id,
          name: jobTitle.name,
        ),
      ),
    );
  }

  void _confirmDelete(dynamic jobTitle) {
    // Capture provider from parent context
    final provider = context.read<OrganizationalStructureProvider>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Data Jabatan'),
        content: const Text('Apakah Anda yakin ingin menghapus data jabatan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await provider.deleteJobTitle(jobTitle.id);
              if (success && mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Data jabatan berhasil dihapus')),
                );
                _loadData();
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
