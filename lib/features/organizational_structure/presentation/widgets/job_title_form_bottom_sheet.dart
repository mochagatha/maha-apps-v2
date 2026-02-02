import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../providers/organizational_structure_provider.dart';

class JobTitleFormBottomSheet extends StatefulWidget {
  final bool isEdit;
  final int? id;
  final String? name;
  final String typeRole;
  final String typeBranch;
  final VoidCallback onSuccess;

  const JobTitleFormBottomSheet({
    super.key,
    required this.isEdit,
    this.id,
    this.name,
    required this.typeRole,
    required this.typeBranch,
    required this.onSuccess,
  });

  @override
  State<JobTitleFormBottomSheet> createState() => _JobTitleFormBottomSheetState();
}

class _JobTitleFormBottomSheetState extends State<JobTitleFormBottomSheet> {
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
      success = await provider.updateJobTitle(id: widget.id!, name: _nameController.text.trim());
    } else {
      success = await provider.addJobTitle(
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
        SuccessDialog.show(
          context,
          message: 'Jabatan telah berhasil',
          messageActionText: widget.isEdit ? 'diubah' : 'ditambahkan',
          onConfirm: () {
            widget.onSuccess();
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              provider.errorMessage ??
                  (widget.isEdit ? 'Gagal mengubah jabatan' : 'Gagal menambahkan jabatan'),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.isEdit ? 'Edit Jabatan' : 'Tambah Jabatan',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama Jabatan',
                hintText: 'Masukkan nama jabatan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama jabatan tidak boleh kosong';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: SpinKitThreeBounce(color: Colors.white),
                      )
                    : Text(
                        widget.isEdit ? 'Simpan Perubahan' : 'Tambah',
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
