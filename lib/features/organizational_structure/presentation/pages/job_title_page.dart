import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/organizational_structure_provider.dart';
import '../widgets/job_title_list_widget.dart';
import '../widgets/job_title_form_bottom_sheet.dart';

class JobTitlePage extends StatefulWidget {
  final String typeRole;
  final String typeBranch;
  final String title;

  const JobTitlePage({
    super.key,
    required this.typeRole,
    required this.typeBranch,
    required this.title,
  });

  @override
  State<JobTitlePage> createState() => _JobTitlePageState();
}

class _JobTitlePageState extends State<JobTitlePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<OrganizationalStructureProvider>();
    await provider.loadJobTitles(typeRole: widget.typeRole, typeBranch: widget.typeBranch);
  }

  void _showAddJobTitleSheet() {
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
          isEdit: false,
          typeRole: widget.typeRole,
          typeBranch: widget.typeBranch,
          onSuccess: _loadData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.jobTitles.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          return JobTitleListWidget(
            jobTitles: provider.jobTitles,
            typeRole: widget.typeRole,
            typeBranch: widget.typeBranch,
            onRefresh: _loadData,
          );
        },
      ),
      bottomNavigationBar: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.jobTitles.isEmpty) {
            return const SizedBox.shrink();
          }

          return BottomAppBar(
            height: 70,
            elevation: 0,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _showAddJobTitleSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Tambah Jabatan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
