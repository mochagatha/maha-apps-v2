import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/widgets/success_dialog.dart';
import '../providers/employment_level_provider.dart';

class EmploymentLevelFormBottomSheet extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final String? name;
  final String typeRole;
  final VoidCallback onSuccess;

  const EmploymentLevelFormBottomSheet({
    super.key,
    required this.isEdit,
    this.id,
    this.name,
    required this.typeRole,
    required this.onSuccess,
  });

  @override
  State<EmploymentLevelFormBottomSheet> createState() => _EmploymentLevelFormBottomSheetState();
}

class _EmploymentLevelFormBottomSheetState extends State<EmploymentLevelFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isSubmitting = false;

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
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    final provider = context.read<EmploymentLevelProvider>();
    bool success;

    if (widget.isEdit) {
      success = await provider.updateEmploymentLevelData(
        id: widget.id!,
        name: _nameController.text.trim(),
      );
    } else {
      success = await provider.addEmploymentLevelData(
        name: _nameController.text.trim(),
        typeRole: widget.typeRole,
      );
    }

    setState(() {
      _isSubmitting = false;
    });

    if (mounted) {
      if (success) {
        Navigator.pop(context);
        SuccessDialog.show(
          context,
          message: 'Tingkatan telah berhasil',
          messageActionText: widget.isEdit ? 'diupdate' : 'ditambahkan',
          onConfirm: () {
            widget.onSuccess();
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ??
                  (widget.isEdit ? 'Gagal mengupdate tingkatan' : 'Gagal menambahkan tingkatan'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.isEdit ? 'Edit Tingkatan' : 'Tambah Tingkatan',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Tingkatan',
                hintText: 'Masukkan nama tingkatan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama tingkatan tidak boleh kosong';
                }
                return null;
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
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
                        child: SpinKitThreeBounce(color: Colors.white),
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
  }
}
