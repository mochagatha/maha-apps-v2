import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/employee_entity.dart';

class SelectEmployeeDialog extends StatefulWidget {
  final Future<List<EmployeeEntity>> employeesFuture;
  final List<EmployeeEntity> initialSelectedEmployees;

  const SelectEmployeeDialog({
    super.key,
    required this.employeesFuture,
    this.initialSelectedEmployees = const [],
  });

  @override
  State<SelectEmployeeDialog> createState() => _SelectEmployeeDialogState();
}

class _SelectEmployeeDialogState extends State<SelectEmployeeDialog> {
  late List<EmployeeEntity> _selectedEmployees;
  List<EmployeeEntity>? _employees;
  List<EmployeeEntity> _filteredEmployees = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedEmployees = List.from(widget.initialSelectedEmployees);
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_employees == null) return;

    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredEmployees = _employees!;
      } else {
        _filteredEmployees = _employees!.where((employee) {
          return employee.fullname.toLowerCase().contains(query) ||
              employee.nik.toLowerCase().contains(query) ||
              (employee.jobTitleName?.toLowerCase().contains(query) ?? false);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Pilih Pekerja',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search field
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari Pekerja Disini',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: AppColors.blue),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Employee list with FutureBuilder
            Expanded(
              child: FutureBuilder<List<EmployeeEntity>>(
                future: widget.employeesFuture,
                builder: (context, snapshot) {
                  // Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitThreeBounce(color: AppColors.primary),
                    );
                  }

                  // Error state
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Gagal memuat data pekerja',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    );
                  }

                  // Initialize _employees and _filteredEmployees on first load
                  final employees = snapshot.data ?? [];
                  if (_employees == null) {
                    _employees = employees;
                    _filteredEmployees = employees;
                  } else if (_employees != employees) {
                    // Update _employees when data changes
                    _employees = employees;
                    _filteredEmployees = employees;
                  }

                  // Empty state
                  if (employees.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada data pekerja',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // No search results
                  if (_filteredEmployees.isEmpty) {
                    return const Center(
                      child: Text(
                        'Tidak ada hasil pencarian',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  // Employee list
                  return ListView.separated(
                    itemCount: _filteredEmployees.length,
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final employee = _filteredEmployees[index];
                      final isSelected = _selectedEmployees.any((e) => e.id == employee.id);

                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedEmployees.removeWhere((e) => e.id == employee.id);
                            } else {
                              _selectedEmployees.add(employee);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(employee.photoUrl),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      employee.fullname,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    if (employee.jobTitleName != null)
                                      Text(
                                        employee.jobTitleName!,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      _selectedEmployees.add(employee);
                                    } else {
                                      _selectedEmployees.removeWhere(
                                        (e) => e.id == employee.id,
                                      );
                                    }
                                  });
                                },
                                activeColor: AppColors.blue,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            // Button
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _selectedEmployees);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Pilih${_selectedEmployees.isNotEmpty ? ' (${_selectedEmployees.length})' : ''}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
