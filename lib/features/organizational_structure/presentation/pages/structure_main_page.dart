import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/utils/localization_extension.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../../shared/widgets/confirm_dialog.dart';
import '../../../../shared/widgets/success_dialog.dart';
import '../providers/structure_provider.dart';
import '../providers/job_title_provider.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../domain/entities/role_structure_entity.dart';
import '../../domain/entities/superior_employee_entity.dart';
import '../../domain/entities/user_role_entity.dart';
import '../widgets/superior_employee_form_bottom_sheet.dart';
import 'structure_team_page.dart';
import 'add_department_members_page.dart';
import '../../../../core/di/injection_container.dart';

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
            return const Center(child: SpinKitThreeBounce(color: AppColors.primary));
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: AppColors.primary),
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
                      backgroundColor: AppColors.primary,
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
      color: AppColors.primary,
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
                  style: TextStyle(fontSize: 14, color: AppColors.neutral6),
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
                    backgroundColor: AppColors.blue,
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
                    backgroundColor: AppColors.primary,
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
            color: AppColors.primary,
            onRefresh: _loadData,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: structure.roleStructure.length,
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
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
    return InkWell(
      onTap: role.superiorEmployeeStructure.isNotEmpty
          ? null
          : () => _navigateToJobTitleSelection(companyStructureId, role.id),
      child: Container(
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
                Expanded(flex: 1, child: SizedBox()),
                Expanded(
                  flex: 6,
                  child: Text(
                    role.userRole.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Builder(
                    builder: (buttonContext) => IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.grey),
                      onPressed: () => _showRoleMenu(role.id, buttonContext),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
            if (role.superiorEmployeeStructure.isNotEmpty) ...[
              ...role.superiorEmployeeStructure.map((superior) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () => _navigateToTeamManagement(superior.id),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(superior.employee.photoUrl),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () =>
                                _showEditSuperiorDialog(superior, companyStructureId, role.id),
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColors.blue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.edit, size: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      superior.employee.fullname,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      superior.employee.nik,
                      style: TextStyle(fontSize: 12, color: AppColors.neutral6),
                    ),
                    SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => _navigateToAddDepartment(
                          companyStructureId: companyStructureId,
                          roleStructureId: role.id,
                          superiorEmployeeId: superior.id,
                        ),
                        icon: const Icon(Icons.add_box_outlined, size: 26),
                        label: const Text(
                          "Tambah Departemen",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.blue,
                          side: const BorderSide(color: AppColors.blue, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ],
        ),
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
              onPressed: provider.isLoading ? null : _addStructureDialog,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
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

  void _navigateToJobTitleSelection(int companyStructureId, int roleStructureId) async {
    await context.pushNamed(
      RouteNames.jobTitleSelection,
      queryParameters: {
        'companyStructureId': companyStructureId.toString(),
        'roleStructureId': roleStructureId.toString(),
      },
    );
    _loadData();
  }

  void _navigateToAddDepartment({
    required int companyStructureId,
    required int roleStructureId,
    required int superiorEmployeeId,
  }) async {
    final provider = context.read<StructureProvider>();
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider.value(
          value: provider,
          child: AddDepartmentMembersPage(
            companyStructureId: companyStructureId,
            roleStructureId: roleStructureId,
            superiorEmployeeId: superiorEmployeeId,
          ),
        ),
      ),
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
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: this.context.read<StructureProvider>()),
          ChangeNotifierProvider(create: (_) => sl<JobTitleProvider>()),
        ],
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
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: this.context.read<StructureProvider>()),
          ChangeNotifierProvider(create: (_) => sl<JobTitleProvider>()),
        ],
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

  void _addStructureDialog() async {
    final provider = context.read<StructureProvider>();

    // Load user roles list for office employees
    final result = await provider.getOrganizationalData.getUserRolesList(
      typeRole: 'employee',
      typeBranch: 'office',
    );

    if (!mounted) return;

    // Handle the result
    final availableRoles = result.fold((failure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(failure.message)));
      return <UserRoleEntity>[];
    }, (roles) => roles);

    if (availableRoles.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Tidak ada data tingkatan pekerjaan')));
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

    final dialogResult = await showDialog<bool>(
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
                  'Daftar Tingkatan Pekerjaan',
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
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
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
                                activeColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (role != selectableRoles.last) const SizedBox(height: 12),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedRoleIds.isEmpty ? null : () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: Text(
                      'Pilih',
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

    if (dialogResult == true && selectedRoleIds.isNotEmpty) {
      _showConfirmationDialog(selectedRoleIds.toList());
    }
  }

  void _showConfirmationDialog(List<int> selectedRoleIds) {
    ConfirmDialog.show(
      context,
      message: context.l10n.confirmAddJobLevelStructure,
      onConfirm: () {
        _addRoles(selectedRoleIds);
      },
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
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  void _showSuccessDialog() {
    SuccessDialog.show(
      context,
      title: context.l10n.successExclamation,
      message: context.l10n.jobLevelAddedSuccess,
    );
  }

  void _showRoleMenu(int roleId, BuildContext buttonContext) {
    final RenderBox button = buttonContext.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(buttonContext).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu<String>(
      context: buttonContext,
      position: position,
      items: [
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete_outline, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(context.l10n.delete),
            ],
          ),
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        _confirmDeleteRole(roleId);
      }
    });
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
                ).showSnackBar(SnackBar(content: Text(context.l10n.delete)));
                _loadData();
              }
            },
            child: const Text('Hapus', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }
}
