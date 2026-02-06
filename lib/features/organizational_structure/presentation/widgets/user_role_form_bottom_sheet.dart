import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/user_role_entity.dart';
import '../providers/user_role_provider.dart';

class UserRoleFormBottomSheet extends StatefulWidget {
  final String typeRole;
  final String typeBranch;
  final UserRoleEntity? userRole; // null untuk tambah, ada value untuk edit
  final List<UserRoleEntity> availableSupervisorRoles;
  final VoidCallback onSuccess;

  const UserRoleFormBottomSheet({
    super.key,
    required this.typeRole,
    required this.typeBranch,
    this.userRole,
    required this.availableSupervisorRoles,
    required this.onSuccess,
  });

  @override
  State<UserRoleFormBottomSheet> createState() => _UserRoleFormBottomSheetState();
}

class _UserRoleFormBottomSheetState extends State<UserRoleFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  int? _selectedSupervisorRoleId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userRole?.name ?? '');
    _selectedSupervisorRoleId = widget.userRole?.supervisorRoleId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  bool get isEdit => widget.userRole != null;

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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEdit ? 'Edit Tingkatan' : 'Tambah Tingkatan',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Tingkatan',
                    hintText: 'Contoh: Direktur, Manager, dll',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama tingkatan tidak boleh kosong';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: _selectedSupervisorRoleId,
                  decoration: InputDecoration(
                    labelText: 'Atasan Langsung (Opsional)',
                    hintText: 'Pilih atasan langsung',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  items: [
                    const DropdownMenuItem<int>(value: null, child: Text('Tidak ada atasan')),
                    ...widget.availableSupervisorRoles
                        .where((role) => role.id != widget.userRole?.id) // Exclude self
                        .map(
                          (role) => DropdownMenuItem<int>(value: role.id, child: Text(role.name)),
                        )
                        .toList(),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedSupervisorRoleId = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Consumer<UserRoleProvider>(
                    builder: (context, provider, child) {
                      return ElevatedButton(
                        onPressed: provider.isLoading ? null : _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: provider.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: SpinKitThreeBounce(color: Colors.white),
                              )
                            : Text(
                                isEdit ? 'Update' : 'Simpan',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<UserRoleProvider>();
    bool success;

    if (isEdit) {
      success = await provider.updateUserRoleData(
        id: widget.userRole!.id,
        name: _nameController.text.trim(),
        supervisorRoleId: _selectedSupervisorRoleId,
        typeRole: widget.typeRole,
        typeBranch: widget.typeBranch,
      );
    } else {
      success = await provider.addUserRoleData(
        name: _nameController.text.trim(),
        supervisorRoleId: _selectedSupervisorRoleId,
        typeRole: widget.typeRole,
        typeBranch: widget.typeBranch,
      );
    }

    if (!mounted) return;

    if (success) {
      Navigator.pop(context);
      widget.onSuccess();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isEdit ? 'Tingkatan berhasil diupdate' : 'Tingkatan berhasil ditambahkan'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            provider.errorMessage ?? (isEdit ? 'Gagal update tingkatan' : 'Gagal tambah tingkatan'),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
