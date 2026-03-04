import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../providers/department_provider.dart';
import '../widgets/department_list_widget.dart';
import '../widgets/department_form_bottom_sheet.dart';

class DepartmentBranchPage extends StatefulWidget {
  const DepartmentBranchPage({super.key});

  @override
  State<DepartmentBranchPage> createState() => _DepartmentBranchPageState();
}

class _DepartmentBranchPageState extends State<DepartmentBranchPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<DepartmentProvider>();
    await provider.loadDepartmentsByType(typeRole: 'employee', typeBranch: 'branch');
  }

  void _showAddDepartmentSheet() {
    final provider = context.read<DepartmentProvider>();
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
          typeBranch: 'branch',
          onSuccess: _loadData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Data Departemen'),
      body: Consumer<DepartmentProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.departments.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          return DepartmentListWidget(
            departments: provider.departments,
            typeRole: 'employee',
            typeBranch: 'branch',
            onRefresh: _loadData,
          );
        },
      ),
      bottomNavigationBar: Consumer<DepartmentProvider>(
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Tambah Departemen',
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
