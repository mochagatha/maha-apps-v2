import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/superior_employee_entity.dart';
import '../../domain/entities/department_structure_entity.dart';
import '../providers/structure_provider.dart';
import 'add_department_members_page.dart';

class StructureTeamPage extends StatefulWidget {
  final int superiorId;
  final String type;

  const StructureTeamPage({super.key, required this.superiorId, required this.type});

  @override
  State<StructureTeamPage> createState() => _StructureTeamPageState();
}

class _StructureTeamPageState extends State<StructureTeamPage> {
  String get _typeBranch {
    if (widget.type == 'utama') return 'office';
    if (widget.type == 'project') return 'project';
    return 'branch';
  }

  int? _getRoleStructureId(StructureProvider provider) {
    final structure = provider.currentStructure;
    if (structure == null) return null;
    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        if (superior.id == widget.superiorId) return role.id;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final provider = context.read<StructureProvider>();
    provider.loadDepartments();
    provider.loadEmployees();
    // Refresh main structure to ensure ups-to-date
    provider.loadCompanyStructure(widget.type);
  }

  SuperiorEmployeeEntity? _getSuperior(StructureProvider provider) {
    final structure = provider.currentStructure;
    if (structure == null) return null;

    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        if (superior.id == widget.superiorId) return superior;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Manajemen Tim',
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<StructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.currentStructure == null) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          final superior = _getSuperior(provider);

          if (superior == null) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          return RefreshIndicator(
            onRefresh: () async => _loadInitialData(),
            color: Colors.red,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildSuperiorInfo(superior),
                const SizedBox(height: 24),
                _buildDepartmentsList(superior, provider),
              ],
            ),
          );
        },
      ),
      floatingActionButton: Consumer<StructureProvider>(
        builder: (context, provider, _) => FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () => _navigateToAddDepartment(provider),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSuperiorInfo(SuperiorEmployeeEntity superior) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 30, backgroundImage: NetworkImage(superior.employee.photoUrl)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  superior.employee.fullname,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  superior.jobTitle.name ?? "-",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  superior.employee.nik,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentsList(
    SuperiorEmployeeEntity superior,
    StructureProvider provider,
  ) {
    if (superior.departmentStructure.isEmpty) {
      return Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Icon(Icons.folder_open, size: 60, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('Belum ada departemen', style: TextStyle(color: Colors.grey)),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Departemen & Anggota',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ...superior.departmentStructure.map((deptStruct) {
          return _buildDepartmentCard(deptStruct, provider);
        }).toList(),
      ],
    );
  }

  Widget _buildDepartmentCard(
    DepartmentStructureEntity deptStruct,
    StructureProvider provider,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ExpansionTile(
        title: Text(
          deptStruct.department.departmentName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${deptStruct.employeeStructure.length} Karyawan, ${deptStruct.workerStructure.length} Pekerja Harian',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        childrenPadding: const EdgeInsets.all(16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMemberSection(
            title: 'Karyawan',
            members: deptStruct.employeeStructure.map((e) => e.employee).toList(),
          ),
          const Divider(height: 32),
          _buildMemberSection(
            title: 'Pekerja Harian',
            members: deptStruct.workerStructure.map((w) => w.worker).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _deleteDepartment(deptStruct.id),
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Hapus Departemen', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.red)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberSection({
    required String title,
    required List<EmployeeEntity> members,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        if (members.isEmpty)
          const Text('-', style: TextStyle(color: Colors.grey))
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: members.map((member) {
              return Chip(
                avatar: CircleAvatar(backgroundImage: NetworkImage(member.photoUrl)),
                label: Text(member.fullname),
                backgroundColor: Colors.grey.shade100,
              );
            }).toList(),
          ),
      ],
    );
  }

  void _navigateToAddDepartment(StructureProvider provider) async {
    final structure = provider.currentStructure;
    if (structure == null) return;
    final roleStructureId = _getRoleStructureId(provider);
    if (roleStructureId == null) return;

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: provider,
          child: AddDepartmentMembersPage(
            companyStructureId: structure.id,
            roleStructureId: roleStructureId,
            superiorEmployeeId: widget.superiorId,
            typeBranch: _typeBranch,
          ),
        ),
      ),
    );

    if (mounted) _loadInitialData();
  }

  void _deleteDepartment(int deptStructId) {
    final provider = context.read<StructureProvider>();
    ConfirmDialog.show(
      context,
      message: 'Apakah Anda yakin ingin menghapus departemen ini?',
      onConfirm: () async {
        final success = await provider.deleteDepartment(deptStructId);
        if (!mounted) return;
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Departemen berhasil dihapus')),
          );
          _loadInitialData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.errorMessage ?? 'Gagal menghapus departemen'),
              backgroundColor: AppColors.primary,
            ),
          );
        }
      },
    );
  }
}
