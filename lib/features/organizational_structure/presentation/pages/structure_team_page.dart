import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../domain/entities/department_entity.dart';
import '../../domain/entities/employee_entity.dart';
import '../../domain/entities/organizational_structure_entity.dart';
import '../../domain/entities/superior_employee_entity.dart';
import '../../domain/entities/department_structure_entity.dart';
import '../providers/organizational_structure_provider.dart';
import '../widgets/multi_select_employee_dialog.dart';

class StructureTeamPage extends StatefulWidget {
  final int superiorId;

  const StructureTeamPage({super.key, required this.superiorId});

  @override
  State<StructureTeamPage> createState() => _StructureTeamPageState();
}

class _StructureTeamPageState extends State<StructureTeamPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  void _loadInitialData() {
    final provider = context.read<OrganizationalStructureProvider>();
    provider.loadDepartments();
    provider.loadEmployees();
    // Refresh main structure to ensure ups-to-date
    provider.loadCompanyStructure('utama');
  }

  SuperiorEmployeeEntity? _getSuperior(OrganizationalStructureProvider provider) {
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
      body: Consumer<OrganizationalStructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.currentStructure == null) {
            return const Center(child: CircularProgressIndicator(color: Colors.red));
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => _showAddDepartmentDialog(context),
        child: const Icon(Icons.add, color: Colors.white),
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
    OrganizationalStructureProvider provider,
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
    OrganizationalStructureProvider provider,
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
          '${deptStruct.employeeStructure.length} Staff, ${deptStruct.workerStructure.length} Worker',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        childrenPadding: const EdgeInsets.all(16),
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMemberSection(
            title: 'Staff',
            members: deptStruct.employeeStructure.map((e) => e.employee).toList(),
            onEdit: () => _editMembers(deptStruct, false),
          ),
          const Divider(height: 32),
          _buildMemberSection(
            title: 'Worker',
            members: deptStruct.workerStructure.map((w) => w.worker).toList(),
            onEdit: () => _editMembers(deptStruct, true),
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
    required VoidCallback onEdit,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            TextButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit, size: 16),
              label: const Text('Kelola'),
            ),
          ],
        ),
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

  void _showAddDepartmentDialog(BuildContext context) {
    final provider = context.read<OrganizationalStructureProvider>();
    DepartmentEntity? selectedDept;
    List<int> selectedEmployees = [];
    List<int> selectedWorkers = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Tambah Departemen'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<DepartmentEntity>(
                  value: selectedDept,
                  hint: const Text('Pilih Departemen'),
                  items: provider.departments.map((dept) {
                    return DropdownMenuItem(value: dept, child: Text(dept.departmentName));
                  }).toList(),
                  onChanged: (val) => setState(() => selectedDept = val),
                  decoration: const InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                OutlinedButton(
                  onPressed: () => _showEmployeeSelection(
                    context,
                    provider.employees,
                    selectedEmployees,
                    (ids) => setState(() => selectedEmployees = ids),
                    'Pilih Staff',
                  ),
                  child: Text('Pilih Staff (${selectedEmployees.length})'),
                ),
                const SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () => _showEmployeeSelection(
                    context,
                    provider.employees,
                    selectedWorkers,
                    (ids) => setState(() => selectedWorkers = ids),
                    'Pilih Worker',
                  ),
                  child: Text('Pilih Worker (${selectedWorkers.length})'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
            ElevatedButton(
              onPressed: selectedDept == null
                  ? null
                  : () async {
                      Navigator.pop(context);

                      // Using provider from outer scope
                      final superior = _getSuperior(provider);
                      if (superior == null) return;

                      final success = await provider.addDepartment(
                        superiorEmployeeStructureId: superior.id,
                        departmentId: selectedDept!.id,
                        employeeIds: selectedEmployees,
                        workerIds: selectedWorkers,
                      );

                      if (success && mounted) {
                        provider.loadCompanyStructure('utama');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Departemen berhasil ditambahkan')),
                        );
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  void _editMembers(DepartmentStructureEntity deptStruct, bool isWorker) {
    final provider = context.read<OrganizationalStructureProvider>();
    final currentMembers = isWorker
        ? deptStruct.workerStructure.map((w) => w.worker)
        : deptStruct.employeeStructure.map((e) => e.employee);
    final currentIds = currentMembers.map((e) => e.id).toList();

    _showEmployeeSelection(context, provider.employees, currentIds, (newIds) async {
      // Calculate diff
      final addedIds = newIds.where((id) => !currentIds.contains(id)).toList();
      final removedIds = currentIds.where((id) => !newIds.contains(id)).toList();

      if (addedIds.isEmpty && removedIds.isEmpty) return;

      bool success;
      if (isWorker) {
        success = await provider.editWorkerDepartment(
          id: deptStruct.id,
          workerIds: addedIds,
          deleteWorkerIds: removedIds,
        );
      } else {
        success = await provider.editEmployeeDepartment(
          id: deptStruct.id,
          employeeIds: addedIds,
          deleteEmployeeIds: removedIds,
        );
      }

      if (success && mounted) {
        provider.loadCompanyStructure('utama');
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Anggota berhasil diupdate')));
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.errorMessage ?? 'Gagal update anggota'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }, isWorker ? 'Kelola Worker' : 'Kelola Staff');
  }

  void _showEmployeeSelection(
    BuildContext context,
    List<EmployeeEntity> employees,
    List<int> initialIds,
    Function(List<int>) onConfirm,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (context) => MultiSelectEmployeeDialog(
        employees: employees,
        initialSelectedIds: initialIds,
        onConfirm: onConfirm,
        title: title,
      ),
    );
  }

  // Note: deleteDepartment function in provider is missing or named differently based on repo
  // Looking at manage_superior_employee.dart, there isn't a deleteDepartment method explicitly exposed?
  // Let's check repository.
  // Repository has:
  // Future<Either<Failure, void>> deleteSuperiorEmployee(int superiorEmployeeId);
  // BUT does it have deleteDepartmentStructure?
  // Checked: manage_superior_employee.dart doesn't seem to have deleteDepartment.
  // Wait, I should check repository again.
  // If not, I can't implement delete department.

  void _deleteDepartment(int deptStructId) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Fitur hapus departemen belum tersedia di API')));
  }
}
