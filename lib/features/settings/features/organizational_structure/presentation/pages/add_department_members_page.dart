import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:maha_apps_v2/core/utils/localization_extension.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/success_dialog.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../providers/structure_provider.dart';
import '../widgets/select_employee_dialog.dart';

class AddDepartmentMembersPage extends StatefulWidget {
  final int companyStructureId;
  final int roleStructureId;
  final int superiorEmployeeId;

  const AddDepartmentMembersPage({
    super.key,
    required this.companyStructureId,
    required this.roleStructureId,
    required this.superiorEmployeeId,
  });

  @override
  State<AddDepartmentMembersPage> createState() => _AddDepartmentMembersPageState();
}

class _AddDepartmentMembersPageState extends State<AddDepartmentMembersPage> {
  int? _selectedDepartmentId;
  List<EmployeeEntity> _selectedEmployees = [];
  List<EmployeeEntity> _selectedWorkers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<StructureProvider>();
    await provider.loadDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Struktur Utama'),
      body: Consumer<StructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.departments.isEmpty) {
            return const Center(
              child: SpinKitThreeBounce(color: AppColors.primary),
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDepartmentsList(provider.departments),
                      const SizedBox(height: 24),
                      if (_selectedEmployees.isNotEmpty) ...[
                        _buildSelectedMembersList('Anggota Karyawan', _selectedEmployees, true),
                        const SizedBox(height: 16),
                      ],
                      _buildAddMemberButton(
                        'Tambah Anggota Karyawan',
                        Icons.add_box_outlined,
                        () => _showSelectEmployeeDialog(isEmployee: true),
                      ),
                      const SizedBox(height: 24),

                      if (_selectedWorkers.isNotEmpty) ...[
                        _buildSelectedMembersList('Pekerja Harian', _selectedWorkers, false),
                        const SizedBox(height: 16),
                      ],
                      _buildAddMemberButton(
                        'Tambah Pekerja Harian',
                        Icons.add_box_outlined,
                        () => _showSelectEmployeeDialog(isEmployee: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildDepartmentsList(List<DepartmentEntity> departments) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 8,
            color: Colors.grey.shade300,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: departments.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Tidak ada data departemen',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return RadioListTile<int>(
                  value: departments[index].id,
                  groupValue: _selectedDepartmentId,
                  onChanged: (value) {
                    setState(() {
                      _selectedDepartmentId = value;
                    });
                  },
                  title: Text(
                    departments[index].departmentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  activeColor: AppColors.primary,
                  contentPadding: EdgeInsets.zero,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 8,
                );
              },
              itemCount: departments.length,
            ),
    );
  }

  Widget _buildAddMemberButton(String label, IconData icon, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 26),
        label: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.blue,
          side: const BorderSide(color: AppColors.blue, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedMembersList(String title, List<EmployeeEntity> members, bool isEmployee) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ...members.map((member) => _buildSelectedMemberCard(member, isEmployee)),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectedMemberCard(EmployeeEntity employee, bool isEmployee) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.blue.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(employee.photoUrl),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                employee.fullname,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              if (employee.jobTitleName != null)
                Text(
                  employee.jobTitleName!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 4,
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (isEmployee) {
                  _selectedEmployees.remove(employee);
                } else {
                  _selectedWorkers.remove(employee);
                }
              });
            },
            child: Icon(Icons.close, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Consumer<StructureProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.shade300, blurRadius: 8, offset: const Offset(0, -2)),
            ],
          ),
          child: SafeArea(
            child: ElevatedButton(
              onPressed: provider.isLoading ? null : _onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey,
              ),
              child: Text(
                context.l10n.save,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showSelectEmployeeDialog({required bool isEmployee}) async {
    final provider = context.read<StructureProvider>();

    final selectedEmployees = await showDialog<List<EmployeeEntity>>(
      context: context,
      builder: (context) => SelectEmployeeDialog(
        employeesFuture: provider.getEmployeesFuture(),
        initialSelectedEmployees: isEmployee ? _selectedEmployees : _selectedWorkers,
      ),
    );

    if (selectedEmployees != null) {
      setState(() {
        if (isEmployee) {
          _selectedEmployees = selectedEmployees;
        } else {
          _selectedWorkers = selectedEmployees;
        }
      });
    }
  }

  void _onSave() async {
    // Validasi
    if (_selectedDepartmentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih departemen terlebih dahulu')),
      );
      return;
    }

    if (_selectedEmployees.isEmpty && _selectedWorkers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih minimal satu anggota')),
      );
      return;
    }

    // Tampilkan konfirmasi
    // Tampilkan konfirmasi
    ConfirmDialog.show(
      context,
      message: 'Apakah Anda yakin ingin menyimpan data ini?',
      onConfirm: () async {
        final provider = context.read<StructureProvider>();

        final success = await provider.addDepartment(
          superiorEmployeeStructureId: widget.superiorEmployeeId,
          departmentId: _selectedDepartmentId!,
          employeeIds: _selectedEmployees.map((e) => e.id).toList(),
          workerIds: _selectedWorkers.map((e) => e.id).toList(),
        );

        if (!mounted) return;

        if (success) {
          SuccessDialog.show(
            context,
            message: 'Data berhasil disimpan',
            onConfirm: () {
              Navigator.pop(context);
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(provider.errorMessage ?? 'Gagal menyimpan data')),
          );
        }
      },
    );
  }
}
