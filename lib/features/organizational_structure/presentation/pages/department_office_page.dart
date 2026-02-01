import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../providers/organizational_structure_provider.dart';
import '../widgets/department_list_widget.dart';
import '../widgets/department_form_bottom_sheet.dart';

class DepartmentOfficePage extends StatefulWidget {
  const DepartmentOfficePage({super.key});

  @override
  State<DepartmentOfficePage> createState() => _DepartmentOfficePageState();
}

class _DepartmentOfficePageState extends State<DepartmentOfficePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<OrganizationalStructureProvider>();
    await provider.loadDepartmentsByType(
      typeRole: 'employee',
      typeBranch: 'office',
    );
  }

  void _showAddDepartmentSheet() {
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
          isEdit: false,
          typeRole: 'employee',
          typeBranch: 'office',
          onSuccess: _loadData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Data Departemen',
      ),
      body: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.departments.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          return DepartmentListWidget(
            departments: provider.departments,
            typeRole: 'employee',
            typeBranch: 'office',
            onRefresh: _loadData,
          );
        },
      ),
      bottomNavigationBar: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.departments.isEmpty) {
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
                    onPressed: _showAddDepartmentSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Tambah Departemen',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
}
