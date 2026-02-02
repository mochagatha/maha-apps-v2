import 'package:flutter/material.dart';
import '../../domain/entities/employee_entity.dart';

class MultiSelectEmployeeDialog extends StatefulWidget {
  final List<EmployeeEntity> employees;
  final List<int> initialSelectedIds;
  final Function(List<int>) onConfirm;
  final String title;

  const MultiSelectEmployeeDialog({
    super.key,
    required this.employees,
    required this.initialSelectedIds,
    required this.onConfirm,
    required this.title,
  });

  @override
  State<MultiSelectEmployeeDialog> createState() =>
      _MultiSelectEmployeeDialogState();
}

class _MultiSelectEmployeeDialogState extends State<MultiSelectEmployeeDialog> {
  late List<int> _selectedIds;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedIds = List.from(widget.initialSelectedIds);
  }

  @override
  Widget build(BuildContext context) {
    final filteredEmployees = widget.employees.where((e) {
      final query = _searchQuery.toLowerCase();
      return e.fullname.toLowerCase().contains(query) ||
          e.nik.toLowerCase().contains(query);
    }).toList();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: [
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                hintText: 'Cari nama atau NIK...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: filteredEmployees.length,
                itemBuilder: (context, index) {
                  final employee = filteredEmployees[index];
                  final isSelected = _selectedIds.contains(employee.id);
                  return CheckboxListTile(
                    value: isSelected,
                    title: Text(employee.fullname),
                    subtitle: Text(employee.nik),
                    secondary: CircleAvatar(
                      backgroundImage: NetworkImage(employee.photoUrl),
                    ),
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          _selectedIds.add(employee.id);
                        } else {
                          _selectedIds.remove(employee.id);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onConfirm(_selectedIds);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Simpan'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
