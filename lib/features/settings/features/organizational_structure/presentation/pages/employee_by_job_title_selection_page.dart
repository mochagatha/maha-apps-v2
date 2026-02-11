import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/success_dialog.dart';
import '../providers/structure_provider.dart';
import '../../domain/entities/employee_entity.dart';

/// Page for selecting employee by job title to fill structure
class EmployeeByJobTitleSelectionPage extends StatefulWidget {
  final int companyStructureId;
  final int roleStructureId;
  final int jobTitleId;
  final String jobTitleName;

  const EmployeeByJobTitleSelectionPage({
    super.key,
    required this.companyStructureId,
    required this.roleStructureId,
    required this.jobTitleId,
    required this.jobTitleName,
  });

  @override
  State<EmployeeByJobTitleSelectionPage> createState() => _EmployeeByJobTitleSelectionPageState();
}

class _EmployeeByJobTitleSelectionPageState extends State<EmployeeByJobTitleSelectionPage> {
  final TextEditingController _searchController = TextEditingController();
  List<EmployeeEntity> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<StructureProvider>();
    await provider.loadEmployees(jobTitleId: widget.jobTitleId);
    setState(() {
      _filteredEmployees = provider.employees;
    });
  }

  void _filterEmployees(String query) {
    final provider = context.read<StructureProvider>();
    setState(() {
      if (query.isEmpty) {
        _filteredEmployees = provider.employees;
      } else {
        _filteredEmployees = provider.employees
            .where(
              (employee) =>
                  employee.fullname.toLowerCase().contains(query.toLowerCase()) ||
                  employee.nik.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onEmployeeSelected(EmployeeEntity employee) {
    ConfirmDialog.show(
      context,
      message: "Apakah anda yakin ingin menambahkan Struktur?",
      onConfirm: () async {
        await _addEmployeeToStructure(employee);
      },
    );
  }

  Future<void> _addEmployeeToStructure(EmployeeEntity employee) async {
    final provider = context.read<StructureProvider>();

    final success = await provider.addSuperiorEmployee(
      companyStructureId: widget.companyStructureId,
      roleStructureId: widget.roleStructureId,
      employeeId: employee.id,
      jobTitleId: widget.jobTitleId,
    );

    if (!mounted) return;

    if (success) {
      SuccessDialog.show(
        context,
        message: "Karyawan berhasil ditambahkan ke struktur",
        onConfirm: () {
          context.pop();
          context.pop();
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? 'Gagal menambahkan karyawan'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pilih Karyawan',
      ),
      body: Consumer<StructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.employees.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: AppColors.primary));
          }

          if (provider.errorMessage != null && provider.employees.isEmpty) {
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

          return Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari nama karyawan...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              _filterEmployees('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onChanged: _filterEmployees,
                ),
              ),

              // Employee list
              Expanded(
                child: _filteredEmployees.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.people_outline, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text(
                              'Tidak ada karyawan ditemukan',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: _filteredEmployees.length,
                        itemBuilder: (context, index) {
                          final employee = _filteredEmployees[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.blue.withOpacity(0.3), width: 1),
                            ),
                            child: InkWell(
                              onTap: () => _onEmployeeSelected(employee),
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage: NetworkImage(employee.photoUrl),
                                      backgroundColor: Colors.grey.shade200,
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            employee.fullname,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            employee.nik,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
