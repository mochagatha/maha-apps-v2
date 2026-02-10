import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import '../../../../../../shared/theme/app_theme.dart';
import '../../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../../core/utils/localization_extension.dart';
import '../../domain/entities/organizational_structure_entity.dart';
import '../../domain/entities/role_structure_entity.dart';
import '../../domain/entities/superior_employee_entity.dart';
import '../../domain/entities/department_structure_entity.dart';

class OrganizationChartPage extends StatefulWidget {
  final OrganizationalStructureEntity structure;

  const OrganizationChartPage({super.key, required this.structure});

  @override
  State<OrganizationChartPage> createState() => _OrganizationChartPageState();
}

class _OrganizationChartPageState extends State<OrganizationChartPage> {
  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    super.initState();
    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    // Build graph on init
    _buildGraph(widget.structure);
  }

  void _buildGraph(OrganizationalStructureEntity? structure) {
    if (structure == null) return;

    graph.nodes.clear();
    graph.edges.clear();

    // Create root node for company
    final rootNode = Node.Id('root');
    graph.addNode(rootNode);

    // Build hierarchy from role structures
    for (var role in structure.roleStructure) {
      _addRoleNode(rootNode, role);
    }
  }

  void _addRoleNode(Node parentNode, RoleStructureEntity role) {
    final roleNodeId = 'role_${role.id}';
    final roleNode = Node.Id(roleNodeId);
    graph.addNode(roleNode);
    graph.addEdge(parentNode, roleNode);

    // Add superior employees under this role
    for (var superior in role.superiorEmployeeStructure) {
      _addSuperiorNode(roleNode, superior);
    }
  }

  void _addSuperiorNode(Node parentNode, SuperiorEmployeeEntity superior) {
    final superiorNodeId = 'superior_${superior.id}';
    final superiorNode = Node.Id(superiorNodeId);
    graph.addNode(superiorNode);
    graph.addEdge(parentNode, superiorNode);

    // Add departments under superior
    for (var department in superior.departmentStructure) {
      _addDepartmentNode(superiorNode, department);
    }
  }

  void _addDepartmentNode(Node parentNode, DepartmentStructureEntity department) {
    final deptNodeId = 'dept_${department.id}';
    final deptNode = Node.Id(deptNodeId);
    graph.addNode(deptNode);
    graph.addEdge(parentNode, deptNode);

    // Add employees under department
    for (var employee in department.employeeStructure) {
      final empNodeId = 'emp_${employee.id}';
      final empNode = Node.Id(empNodeId);
      graph.addNode(empNode);
      graph.addEdge(deptNode, empNode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: context.l10n.organizationChart),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 0.01,
        maxScale: 5.6,
        child: GraphView(
          graph: graph,
          algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
          paint: Paint()
            ..color = AppColors.blue
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            return _buildNodeWidget(node, widget.structure);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _buildGraph(widget.structure);
          });
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }

  Widget _buildNodeWidget(Node node, OrganizationalStructureEntity structure) {
    final nodeId = node.key?.value as String;

    if (nodeId == 'root') {
      return _buildRootNode(structure);
    } else if (nodeId.startsWith('role_')) {
      final roleId = int.parse(nodeId.split('_')[1]);
      final role = structure.roleStructure.firstWhere((r) => r.id == roleId);
      return _buildRoleNodeWidget(role);
    } else if (nodeId.startsWith('superior_')) {
      final superiorId = int.parse(nodeId.split('_')[1]);
      final superior = _findSuperiorById(structure, superiorId);
      if (superior != null) {
        return _buildSuperiorNodeWidget(superior);
      }
    } else if (nodeId.startsWith('dept_')) {
      final deptId = int.parse(nodeId.split('_')[1]);
      final dept = _findDepartmentById(structure, deptId);
      if (dept != null) {
        return _buildDepartmentNodeWidget(dept);
      }
    } else if (nodeId.startsWith('emp_')) {
      final empId = int.parse(nodeId.split('_')[1]);
      final emp = _findEmployeeStructureById(structure, empId);
      if (emp != null) {
        return _buildEmployeeNodeWidget(emp.employee.fullname, emp.employee.photoUrl);
      }
    }

    return _buildDefaultNode();
  }

  Widget _buildRootNode(OrganizationalStructureEntity structure) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.business, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          const Text(
            'Struktur Organisasi',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleNodeWidget(RoleStructureEntity role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.blue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.workspace_premium, color: Colors.white, size: 24),
          const SizedBox(height: 4),
          Text(
            role.userRole.name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSuperiorNodeWidget(SuperiorEmployeeEntity superior) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: AppColors.blue, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(superior.employee.photoUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 100,
            child: Text(
              superior.employee.fullname,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            superior.employee.nik,
            style: TextStyle(
              fontSize: 10,
              color: AppColors.neutral6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentNodeWidget(DepartmentStructureEntity dept) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: AppColors.neutral4, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.group_work, color: AppColors.blue, size: 20),
          const SizedBox(height: 4),
          SizedBox(
            width: 100,
            child: Text(
              dept.department.departmentName,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeNodeWidget(String name, String photoUrl) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: Border.all(color: AppColors.neutral3, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(photoUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultNode() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200,
      ),
      child: const Icon(Icons.help_outline, size: 24),
    );
  }

  SuperiorEmployeeEntity? _findSuperiorById(
    OrganizationalStructureEntity structure,
    int superiorId,
  ) {
    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        if (superior.id == superiorId) {
          return superior;
        }
      }
    }
    return null;
  }

  DepartmentStructureEntity? _findDepartmentById(
    OrganizationalStructureEntity structure,
    int deptId,
  ) {
    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        for (var dept in superior.departmentStructure) {
          if (dept.id == deptId) {
            return dept;
          }
        }
      }
    }
    return null;
  }

  dynamic _findEmployeeStructureById(
    OrganizationalStructureEntity structure,
    int empId,
  ) {
    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        for (var dept in superior.departmentStructure) {
          for (var emp in dept.employeeStructure) {
            if (emp.id == empId) {
              return emp;
            }
          }
        }
      }
    }
    return null;
  }
}
