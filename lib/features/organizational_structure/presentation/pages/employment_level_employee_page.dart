import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/organizational_structure_provider.dart';
import '../widgets/employment_level_list_widget.dart';
import '../widgets/employment_level_form_bottom_sheet.dart';

class EmploymentLevelEmployeePage extends StatefulWidget {
  const EmploymentLevelEmployeePage({super.key});

  @override
  State<EmploymentLevelEmployeePage> createState() => _EmploymentLevelEmployeePageState();
}

class _EmploymentLevelEmployeePageState extends State<EmploymentLevelEmployeePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<OrganizationalStructureProvider>();
    await provider.loadEmploymentLevelsByType(typeRole: 'employee');
  }

  void _showAddEmploymentLevelSheet() {
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
          isEdit: false,
          typeRole: 'employee',
          onSuccess: _loadData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Data Tingkatan Karyawan'),
      body: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.employmentLevels.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          return EmploymentLevelListWidget(
            employmentLevels: provider.employmentLevels,
            typeRole: 'employee',
            onRefresh: _loadData,
          );
        },
      ),
      bottomNavigationBar: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.employmentLevels.isEmpty) {
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
                    onPressed: _showAddEmploymentLevelSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Tambah Tingkatan',
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
