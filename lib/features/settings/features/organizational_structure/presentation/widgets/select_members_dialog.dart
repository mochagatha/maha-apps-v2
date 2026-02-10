import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../domain/entities/employee_entity.dart';

/// Dialog for selecting members (employees or workers) with UI consistent with structure_main_page
class SelectMembersDialog extends StatefulWidget {
  final String title;
  final List<EmployeeEntity> allEmployees;
  final List<int> initialSelectedIds;
  final bool isLoading;

  const SelectMembersDialog({
    super.key,
    required this.title,
    required this.allEmployees,
    this.initialSelectedIds = const [],
    this.isLoading = false,
  });

  @override
  State<SelectMembersDialog> createState() => _SelectMembersDialogState();
}

class _SelectMembersDialogState extends State<SelectMembersDialog> {
  late Set<int> _selectedEmployeeIds;
  final TextEditingController _searchController = TextEditingController();
  List<EmployeeEntity> _filteredEmployees = [];

  @override
  void initState() {
    super.initState();
    _selectedEmployeeIds = Set<int>.from(widget.initialSelectedIds);
    _filteredEmployees = widget.allEmployees;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      if (query.isEmpty) {
        _filteredEmployees = widget.allEmployees;
      } else {
        _filteredEmployees = widget.allEmployees.where((employee) {
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                hintText: 'Cari nama atau NIK...',
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

            // Employee list
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: widget.isLoading
                  ? const Center(
                      child: SpinKitThreeBounce(color: AppColors.primary),
                    )
                  : _filteredEmployees.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          'Tidak ada karyawan ditemukan',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: _filteredEmployees.map((employee) {
                          final isSelected = _selectedEmployeeIds.contains(employee.id);
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedEmployeeIds.remove(employee.id);
                                    } else {
                                      _selectedEmployeeIds.add(employee.id);
                                    }
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(employee.photoUrl),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              employee.fullname,
                                              style: const TextStyle(fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              employee.nik,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColors.neutral6,
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
                                              _selectedEmployeeIds.add(employee.id);
                                            } else {
                                              _selectedEmployeeIds.remove(employee.id);
                                            }
                                          });
                                        },
                                        activeColor: AppColors.primary,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
            ),
            const SizedBox(height: 20),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Return selected employee IDs
                  Navigator.pop(context, _selectedEmployeeIds.toList());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  'Simpan${_selectedEmployeeIds.isNotEmpty ? ' (${_selectedEmployeeIds.length})' : ''}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
