import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/router/route_names.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
// import '../../domain/entities/organizational_structure_entity.dart';
import '../../../organizational_structure/domain/entities/employee_entity.dart';
import '../providers/employee_list_provider.dart';

/// Page for selecting an employee before navigating to access menu
class EmployeeSelectionPage extends StatefulWidget {
  const EmployeeSelectionPage({super.key});

  @override
  State<EmployeeSelectionPage> createState() => _EmployeeSelectionPageState();
}

class _EmployeeSelectionPageState extends State<EmployeeSelectionPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EmployeeListProvider>().loadEmployees();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pilih Karyawan'),
      body: Consumer<EmployeeListProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.employees.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
          }

          if (provider.errorMessage != null && provider.employees.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadEmployees(),
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
                              provider.searchEmployees('');
                            },
                          )
                        : null,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onChanged: (value) {
                    provider.searchEmployees(value);
                    setState(() {});
                  },
                ),
              ),

              // Employee list
              Expanded(
                child: provider.filteredEmployees.isEmpty
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
                        itemCount: provider.filteredEmployees.length,
                        itemBuilder: (context, index) {
                          final employee = provider.filteredEmployees[index];
                          return _EmployeeCard(
                            employee: employee,
                            onTap: () {
                              context.pushNamed(
                                RouteNames.accessMenuList,
                                queryParameters: {'employeeId': employee.id.toString()},
                              );
                            },
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

class _EmployeeCard extends StatelessWidget {
  const _EmployeeCard({required this.employee, required this.onTap});

  final EmployeeEntity employee;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.red.shade100,
          backgroundImage: employee.photoUrl.isNotEmpty ? NetworkImage(employee.photoUrl) : null,
          child: employee.photoUrl.isEmpty
              ? Text(
                  employee.fullname.isNotEmpty ? employee.fullname[0].toUpperCase() : 'U',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
              : null,
        ),
        title: Text(
          employee.fullname,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        // subtitle: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const SizedBox(height: 4),
        //     Text(
        //       employee.jobTitle?.name ?? 'Tidak ada jabatan',
        //       style: const TextStyle(fontSize: 14),
        //     ),
        //     if (employee.department != null) ...[
        //       const SizedBox(height: 2),
        //       Text(
        //         employee.department!.departmentName,
        //         style: const TextStyle(fontSize: 12, color: Colors.grey),
        //       ),
        //     ],
        //   ],
        // ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
