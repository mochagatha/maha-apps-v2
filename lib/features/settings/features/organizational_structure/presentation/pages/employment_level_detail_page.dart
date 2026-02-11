import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../../../../shared/widgets/confirm_dialog.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../shared/widgets/success_dialog.dart';
import '../../domain/entities/user_role_entity.dart';
import '../providers/user_role_provider.dart';
import '../widgets/user_role_form_bottom_sheet.dart';

class EmploymentLevelDetailPage extends StatefulWidget {
  final String typeRole;
  final String title;
  final String? typeBranch;

  const EmploymentLevelDetailPage({
    super.key,
    required this.typeRole,
    required this.title,
    this.typeBranch,
  });

  @override
  State<EmploymentLevelDetailPage> createState() => _EmploymentLevelDetailPageState();
}

class _EmploymentLevelDetailPageState extends State<EmploymentLevelDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final provider = context.read<UserRoleProvider>();
    await provider.loadUserRoleHierarchy(widget.typeRole);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Consumer<UserRoleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.userRoleHierarchy.isEmpty) {
            return const Center(child: SpinKitThreeBounce(color: Colors.red));
          }

          if (provider.errorMessage != null) {
            return _buildErrorState(provider.errorMessage!);
          }

          final roles = provider.userRoleHierarchy;

          if (roles.isEmpty) {
            return _buildEmptyState();
          }

          return _buildHierarchyView(roles);
        },
      ),
      bottomNavigationBar: Consumer<UserRoleProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.userRoleHierarchy.isEmpty) {
            return const SizedBox.shrink();
          }

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
                onPressed: () => _showAddForm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Tambah Tingkatan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _loadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ],
      ),
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/icon/data_aproval_kosong.svg', height: 175),
                const SizedBox(height: 20),
                const Text(
                  'Belum Ada Data Tingkatan!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Jangan lupa untuk melihat Data Tingkatan melalui aplikasi Maha!',
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

  Widget _buildHierarchyView(List<UserRoleEntity> roles) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: roles.map((role) => _buildRoleHierarchy(role)).toList(),
      ),
    );
  }

  Widget _buildRoleHierarchy(UserRoleEntity role, {int level = 0}) {
    return Column(
      children: [
        _buildRoleCard(role, level),
        if (role.subordinates.isNotEmpty) ...[
          const SizedBox(height: 8),
          _buildArrow(),
          const SizedBox(height: 8),
          ...role.subordinates.map(
            (subordinate) => _buildRoleHierarchy(subordinate, level: level + 1),
          ),
        ],
      ],
    );
  }

  Widget _buildRoleCard(UserRoleEntity role, int level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade400, width: 1, style: BorderStyle.solid),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              role.name,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, size: 20),
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 30,
                child: Text('Hapus'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                _showEditForm(role);
              } else if (value == 'delete') {
                _showDeleteConfirmation(role);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildArrow() {
    return const Icon(Icons.arrow_downward, size: 20, color: Colors.grey);
  }

  List<UserRoleEntity> _getAllRoles() {
    final provider = context.read<UserRoleProvider>();
    List<UserRoleEntity> allRoles = [];

    void collectRoles(List<UserRoleEntity> roles) {
      for (var role in roles) {
        allRoles.add(role);
        if (role.subordinates.isNotEmpty) {
          collectRoles(role.subordinates);
        }
      }
    }

    collectRoles(provider.userRoleHierarchy);
    return allRoles;
  }

  void _showAddForm() {
    final allRoles = _getAllRoles();
    final provider = context.read<UserRoleProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: UserRoleFormBottomSheet(
          typeRole: widget.typeRole,
          typeBranch: widget.typeBranch ?? 'office',
          availableSupervisorRoles: allRoles,
          onSuccess: _loadData,
        ),
      ),
    );
  }

  void _showEditForm(UserRoleEntity role) {
    final allRoles = _getAllRoles();
    final provider = context.read<UserRoleProvider>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChangeNotifierProvider.value(
        value: provider,
        child: UserRoleFormBottomSheet(
          typeRole: widget.typeRole,
          typeBranch: widget.typeBranch ?? 'office',
          userRole: role,
          availableSupervisorRoles: allRoles,
          onSuccess: _loadData,
        ),
      ),
    );
  }

  void _showDeleteConfirmation(UserRoleEntity role) {
    ConfirmDialog.show(
      context,
      title: 'Konfirmasi Hapus',
      message: 'Apakah Anda yakin ingin',
      messageActionText: 'menghapus tingkatan "${role.name}"',
      onConfirm: () async {
        final provider = context.read<UserRoleProvider>();
        final success = await provider.deleteUserRoleData(role.id);

        if (!mounted) return;

        if (success) {
          SuccessDialog.show(
            context,
            message: 'Tingkatan "${role.name}" berhasil dihapus',
            onConfirm: _loadData,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(provider.errorMessage ?? 'Gagal menghapus tingkatan'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
    );
  }
}
