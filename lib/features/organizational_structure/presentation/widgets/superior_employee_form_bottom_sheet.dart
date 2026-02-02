import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../providers/structure_provider.dart';
import '../providers/job_title_provider.dart';

class SuperiorEmployeeFormBottomSheet extends StatefulWidget {
  final int companyStructureId;
  final int roleStructureId;
  final VoidCallback onSuccess;
  final bool isEdit;
  final int? superiorEmployeeId;
  final int? initialEmployeeId;
  final int? initialJobTitleId;

  const SuperiorEmployeeFormBottomSheet({
    super.key,
    required this.companyStructureId,
    required this.roleStructureId,
    required this.onSuccess,
    this.isEdit = false,
    this.superiorEmployeeId,
    this.initialEmployeeId,
    this.initialJobTitleId,
  });

  @override
  State<SuperiorEmployeeFormBottomSheet> createState() => _SuperiorEmployeeFormBottomSheetState();
}

class _SuperiorEmployeeFormBottomSheetState extends State<SuperiorEmployeeFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedEmployeeId;
  int? _selectedJobTitleId;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedEmployeeId = widget.initialEmployeeId;
    _selectedJobTitleId = widget.initialJobTitleId;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<StructureProvider>();
    final jobTitleProvider = context.read<JobTitleProvider>();
    // Load employees dan job titles jika belum ada
    if (provider.employees.isEmpty) {
      provider.loadEmployees();
    }
    // Load job titles for 'utama' branch? or general?
    // Assuming 'utama' for now as this is Main Structure
    jobTitleProvider.loadJobTitles(typeRole: 'employee', typeBranch: 'utama');
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedEmployeeId == null || _selectedJobTitleId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Karyawan dan Jabatan harus dipilih')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final provider = context.read<StructureProvider>();
    bool success;

    if (widget.isEdit) {
      success = await provider.editSuperiorEmployee(
        superiorEmployeeId: widget.superiorEmployeeId!,
        employeeId: _selectedEmployeeId!,
        jobTitleId: _selectedJobTitleId!,
      );
    } else {
      success = await provider.addSuperiorEmployee(
        companyStructureId: widget.companyStructureId,
        roleStructureId: widget.roleStructureId,
        employeeId: _selectedEmployeeId!,
        jobTitleId: _selectedJobTitleId!,
      );
    }

    setState(() {
      _isSubmitting = false;
    });

    if (mounted) {
      if (success) {
        Navigator.pop(context);
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ??
                  (widget.isEdit ? 'Gagal mengupdate atasan' : 'Gagal menambahkan atasan'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 60),
              const SizedBox(height: 16),
              Text(
                widget.isEdit ? 'Atasan Berhasil Diupdate!' : 'Atasan Berhasil Ditambahkan!',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onSuccess();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<StructureProvider, JobTitleProvider>(
      builder: (context, provider, jobTitleProvider, child) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.isEdit ? 'Edit Atasan' : 'Tambah Atasan',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Dropdown Karyawan
                DropdownButtonFormField<int>(
                  value: _selectedEmployeeId,
                  decoration: InputDecoration(
                    labelText: 'Nama Karyawan',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: provider.employees.map((employee) {
                    return DropdownMenuItem<int>(
                      value: employee.id,
                      child: Text(
                        '${employee.fullname} - ${employee.nik}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedEmployeeId = value;
                    });
                  },
                  validator: (value) => value == null ? 'Pilih karyawan' : null,
                  isExpanded: true,
                  hint: const Text('Pilih Karyawan'),
                ),
                const SizedBox(height: 16),

                // Dropdown Jabatan
                DropdownButtonFormField<int>(
                  value: _selectedJobTitleId,
                  decoration: InputDecoration(
                    labelText: 'Jabatan',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  items: jobTitleProvider.jobTitles.map((job) {
                    return DropdownMenuItem<int>(value: job.id, child: Text(job.name ?? "-"));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedJobTitleId = value;
                    });
                  },
                  validator: (value) => value == null ? 'Pilih jabatan' : null,
                  isExpanded: true,
                  hint: const Text('Pilih Jabatan'),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isSubmitting || provider.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: SpinKitThreeBounce(color: Colors.white, size: 20),
                          )
                        : Text(
                            widget.isEdit ? 'Update' : 'Simpan',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
