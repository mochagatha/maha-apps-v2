import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/organizational_structure_provider.dart';

class JobTitleFormBottomSheet extends StatefulWidget {
  final bool isEdit;
  final String typeRole; // 'employee' or 'worker'
  final String typeBranch; // 'office' or 'project'
  final int? id;
  final String? name;

  const JobTitleFormBottomSheet({
    super.key,
    required this.isEdit,
    required this.typeRole,
    required this.typeBranch,
    this.id,
    this.name,
  });

  @override
  State<JobTitleFormBottomSheet> createState() => _JobTitleFormBottomSheetState();
}

class _JobTitleFormBottomSheetState extends State<JobTitleFormBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.name != null) {
      _nameController.text = widget.name!;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          top: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.isEdit ? 'Ubah Jabatan' : 'Tambah Jabatan',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff404040),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Jabatan',
                  hintText: 'Tuliskan nama jabatan disini..',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama jabatan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleSubmit(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  widget.isEdit ? 'Ubah' : 'Tambahkan',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(widget.isEdit ? 'Ubah Data Jabatan' : 'Tambah Data Jabatan'),
          content: Text(
            widget.isEdit
                ? 'Apakah Anda yakin ingin mengubah data jabatan ini?'
                : 'Apakah Anda yakin ingin menambahkan data jabatan ini?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(dialogContext); // Close confirmation dialog
                
                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext loadingContext) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.red),
                    );
                  },
                );

                final provider = context.read<OrganizationalStructureProvider>();
                bool success;

                if (widget.isEdit) {
                  success = await provider.updateJobTitle(
                    id: widget.id!,
                    name: _nameController.text.trim(),
                  );
                } else {
                  success = await provider.addJobTitle(
                    name: _nameController.text.trim(),
                    typeRole: widget.typeRole,
                    typeBranch: widget.typeBranch,
                  );
                }

                if (mounted) {
                  Navigator.pop(context); // Close loading dialog
                  Navigator.pop(context); // Close bottom sheet

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.isEdit
                              ? 'Data jabatan berhasil diubah'
                              : 'Data jabatan berhasil ditambahkan',
                        ),
                      ),
                    );
                    
                    // Reload data
                    await provider.loadJobTitles(
                      typeRole: widget.typeRole,
                      typeBranch: widget.typeBranch,
                    );
                  }
                }
              },
              child: Text(
                widget.isEdit ? 'Ubah' : 'Tambahkan',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
