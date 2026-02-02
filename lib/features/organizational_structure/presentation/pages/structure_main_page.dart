import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/localization_extension.dart';
import '../providers/structure_provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../domain/entities/role_structure_entity.dart';
import '../../domain/entities/superior_employee_entity.dart';
import '../widgets/superior_employee_form_bottom_sheet.dart';
import 'structure_team_page.dart';

class StructureMainPage extends StatefulWidget {
  const StructureMainPage({super.key});

  @override
  State<StructureMainPage> createState() => _StructureMainPageState();
}

class _StructureMainPageState extends State<StructureMainPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<StructureProvider>();
    await provider.loadCompanyStructure('utama');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.mainStructure),
      body: Consumer<StructureProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    provider.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadData,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(context.l10n.retry),
                  ),
                ],
              ),
            );
          }

          final structure = provider.currentStructure;

          if (structure == null || structure.roleStructure.isEmpty) {
            return _buildEmptyState();
          }

          return _buildDataDisplay(structure);
        },
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/empty_structure.png',
                  width: 200,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.assignment_outlined, size: 120, color: Colors.grey.shade400);
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  context.l10n.emptyStructureTitle,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  context.l10n.emptyStructureMessage,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataDisplay(dynamic structure) {
    return Column(
      children: [
        // Action buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(context.l10n.featureComingSoon)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    context.l10n.showChart,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(context.l10n.featureComingSoon)));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    context.l10n.archive,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Role structure list
        Expanded(
          child: RefreshIndicator(
            color: Colors.red,
            onRefresh: _loadData,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: structure.roleStructure.length,
              itemBuilder: (context, index) {
                final role = structure.roleStructure[index];
                return _buildRoleStructureCard(role, structure.id);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleStructureCard(RoleStructureEntity role, int companyStructureId) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 8, color: Colors.grey.shade300, offset: const Offset(3, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  role.userRole.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Colors.grey),
                onPressed: () => _showRoleMenu(role.id),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          Divider(color: Colors.grey.shade300),
          if (role.superiorEmployeeStructure.isNotEmpty) ...[
            ...role.superiorEmployeeStructure.map((superior) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  onTap: () => _navigateToTeamManagement(superior.id),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(superior.employee.photoUrl),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              superior.employee.fullname,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              superior.employee.nik,
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                            Text(
                              superior.jobTitle.name ?? "-",
                              style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                            onPressed: () =>
                                _showEditSuperiorDialog(superior, companyStructureId, role.id),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minHeight: 24, minWidth: 24),
                          ),
                          const SizedBox(height: 8),
                          IconButton(
                            icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                            onPressed: () => _confirmDeleteSuperior(superior.id),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(minHeight: 24, minWidth: 24),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],

          // Button Tambah Pejabat jika kosong atau allowed multiple (asumsi multiple allowed based on List)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showAddSuperiorDialog(companyStructureId, role.id),
                icon: const Icon(Icons.add, size: 18),
                label: const Text("Tambah Pejabat"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                ),
              ),
            ),
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
              onPressed: provider.isLoading ? null : _showAddRoleDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                disabledBackgroundColor: Colors.grey,
              ),
              child: Text(
                context.l10n.addMainStructureLevel,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  // Action Methods
  void _navigateToTeamManagement(int superiorId) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StructureTeamPage(superiorId: superiorId)),
    );
    _loadData();
  }

  void _showAddSuperiorDialog(int companyStructureId, int roleStructureId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: context.read<StructureProvider>(),
        child: SuperiorEmployeeFormBottomSheet(
          companyStructureId: companyStructureId,
          roleStructureId: roleStructureId,
          onSuccess: _loadData,
        ),
      ),
    );
  }

  void _showEditSuperiorDialog(
    SuperiorEmployeeEntity superior,
    int companyStructureId,
    int roleStructureId,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => ChangeNotifierProvider.value(
        value: context.read<StructureProvider>(),
        child: SuperiorEmployeeFormBottomSheet(
          companyStructureId: companyStructureId,
          roleStructureId: roleStructureId,
          isEdit: true,
          superiorEmployeeId: superior.id,
          initialEmployeeId: superior.employee.id,
          initialJobTitleId: superior.jobTitle.id,
          onSuccess: _loadData,
        ),
      ),
    );
  }

  void _confirmDeleteSuperior(int superiorId) {
    final provider = context.read<StructureProvider>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hapus Pejabat'),
        content: const Text('Apakah Anda yakin ingin menghapus pejabat ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Batal')),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await provider.deleteSuperiorEmployee(superiorId);
              if (success && mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Pejabat berhasil dihapus')));
                _loadData();
              } else if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(provider.errorMessage ?? 'Gagal menghapus'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showRoleMenu(int roleId) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: Text(context.l10n.deleteRole),
              onTap: () {
                Navigator.pop(context);
                _confirmDeleteRole(roleId);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAddRoleDialog() async {
    final provider = context.read<StructureProvider>();

    // Load available user roles
    await provider.loadUserRoles('utama');

    if (!mounted) return;

    final availableRoles = provider.userRoles;

    if (availableRoles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.noRolesAvailable)));
      return;
    }

    // Get already added role IDs
    final structure = provider.currentStructure;
    final addedRoleIds = structure?.roleStructure.map((r) => r.userRole.id).toSet() ?? <int>{};

    // Filter out already added roles
    final selectableRoles = availableRoles
        .where((role) => !addedRoleIds.contains(role.id))
        .toList();

    if (selectableRoles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.allRolesAdded)));
      return;
    }

    final selectedRoleIds = <int>{};

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.l10n.jobLevelList,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ...selectableRoles.map((role) {
                  final isSelected = selectedRoleIds.contains(role.id);
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedRoleIds.remove(role.id);
                            } else {
                              selectedRoleIds.add(role.id);
                            }
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(role.name, style: const TextStyle(fontSize: 16)),
                              ),
                              Checkbox(
                                value: isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedRoleIds.add(role.id);
                                    } else {
                                      selectedRoleIds.remove(role.id);
                                    }
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (role != selectableRoles.last) const Divider(height: 1),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedRoleIds.isEmpty ? null : () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: Text(
                      context.l10n.select,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    if (result == true && selectedRoleIds.isNotEmpty) {
      _showConfirmationDialog(selectedRoleIds.toList());
    }
  }

  void _showConfirmationDialog(List<int> selectedRoleIds) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.sorryBeforehand,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/confirmation_icon.png',
                width: 100,
                height: 100,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.help_outline, size: 80, color: Colors.orange);
                },
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.confirmAddJobLevelStructure,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(context.l10n.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _addRoles(selectedRoleIds);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(context.l10n.ok),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addRoles(List<int> selectedRoleIds) async {
    final provider = context.read<StructureProvider>();
    final structure = provider.currentStructure;

    if (structure == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.structureNotFound)));
      return;
    }

    final success = await provider.createStructureRole(
      companyStructureId: structure.id,
      userRoleIds: selectedRoleIds,
    );

    if (!mounted) return;

    if (success) {
      _showSuccessDialog();
      await _loadData();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage ?? context.l10n.failedToAddRole),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.l10n.successExclamation,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Text(
                context.l10n.jobLevelAddedSuccess,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    context.l10n.ok,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteRole(int roleId) {
    // Capture provider before dialog
    final provider = context.read<StructureProvider>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.deleteStructureRoleTitle),
        content: Text(context.l10n.deleteStructureRoleMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              final success = await provider.deleteStructureRole(roleId);
              if (success && mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(context.l10n.roleDeletedSuccess)));
                _loadData();
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
