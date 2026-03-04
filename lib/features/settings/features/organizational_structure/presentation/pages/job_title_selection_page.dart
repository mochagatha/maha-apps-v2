import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/router/app_routes.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../providers/job_title_provider.dart';

/// Page for selecting job title when adding/editing employee to structure
class JobTitleSelectionPage extends StatefulWidget {
  final int companyStructureId;
  final int roleStructureId;
  final String typeBranch;
  final bool isEdit;
  final int? superiorEmployeeId;

  const JobTitleSelectionPage({
    super.key,
    required this.companyStructureId,
    required this.roleStructureId,
    this.typeBranch = 'office',
    this.isEdit = false,
    this.superiorEmployeeId,
  });

  @override
  State<JobTitleSelectionPage> createState() => _JobTitleSelectionPageState();
}

class _JobTitleSelectionPageState extends State<JobTitleSelectionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<JobTitleProvider>();
    await provider.loadJobTitles(typeRole: 'employee', typeBranch: widget.typeBranch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Jabatan'),
      body: Consumer<JobTitleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.jobTitles.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          }

          if (provider.errorMessage != null && provider.jobTitles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.primary),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (provider.jobTitles.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.work_outline, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Tidak ada jabatan tersedia',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.jobTitles.length,
            itemBuilder: (context, index) {
              final jobTitle = provider.jobTitles[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      AppRoutes.employeeByJobTitleSelection.name,
                      queryParameters: {
                        'companyStructureId': widget.companyStructureId.toString(),
                        'roleStructureId': widget.roleStructureId.toString(),
                        'jobTitleId': jobTitle.id.toString(),
                        'jobTitleName': jobTitle.name ?? '',
                        'isEdit': widget.isEdit.toString(),
                        if (widget.superiorEmployeeId != null)
                          'superiorEmployeeId': widget.superiorEmployeeId.toString(),
                      },
                    );
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            jobTitle.name ?? 'Unknown',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const Icon(Icons.chevron_right, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
