import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/organizational_structure_provider.dart';

class DepartmentFormBottomSheet extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final String? name;
  final String typeRole;
  final String typeBranch;
  final VoidCallback onSuccess;

  const DepartmentFormBottomSheet({
    super.key,
    required this.isEdit,
    this.id,
    this.name,
    required this.typeRole,
    required this.typeBranch,
    required this.onSuccess,
  });

  @override
  State<DepartmentFormBottomSheet> createState() =>
      _DepartmentFormBottomSheetState();
}

class _DepartmentFormBottomSheetState extends State<DepartmentFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final provider = context.read<OrganizationalStructureProvider>();
    bool success;

    if (widget.isEdit) {
      success = await provider.updateDepartmentData(
        id: widget.id!,
        name: _nameController.text.trim(),
      );
    } else {
      success = await provider.addDepartmentData(
        name: _nameController.text.trim(),
        typeRole: widget.typeRole,
        typeBranch: widget.typeBranch,
      );
    }

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      if (success) {
        Navigator.of(context).pop();
        _showSuccessDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ??
                  (widget.isEdit
                      ? 'Gagal mengubah departemen'
                      : 'Gagal menambahkan departemen'),
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
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Berhasil'),
          content: Text(
            widget.isEdit
                ? 'Data departemen berhasil diubah'
                : 'Data departemen berhasil ditambahkan',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.isEdit ? 'Edit Departemen' : 'Tambah Departemen',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Departemen',
                border: OutlineInputBorder(),
                hintText: 'Masukkan nama departemen',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama departemen tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      widget.isEdit ? 'Simpan' : 'Tambah',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
