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
      ..levelSeparation = (120)
      ..subtreeSeparation = (120)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

    // Build graph on init
    _buildGraph(widget.structure);
  }

  void _buildGraph(OrganizationalStructureEntity? structure) {
    if (structure == null) return;

    graph.nodes.clear();
    graph.edges.clear();

    Node? previousSuperiorNode;

    // Build hierarchy: Superior employees are connected vertically based on role order
    // Departments and employees are under each superior
    for (var role in structure.roleStructure) {
      for (var superior in role.superiorEmployeeStructure) {
        final superiorNodeId = 'superior_${superior.id}_${role.id}';
        final superiorNode = Node.Id(superiorNodeId);
        graph.addNode(superiorNode);

        // Connect to previous superior (vertical hierarchy)
        if (previousSuperiorNode != null) {
          graph.addEdge(previousSuperiorNode, superiorNode);
        }

        // Add departments horizontally under this superior
        for (var department in superior.departmentStructure) {
          _addDepartmentNode(superiorNode, department);
        }

        previousSuperiorNode = superiorNode;
      }
    }
  }

  void _addDepartmentNode(Node parentNode, DepartmentStructureEntity department) {
    final deptNodeId = 'dept_${department.id}';
    final deptNode = Node.Id(deptNodeId);
    graph.addNode(deptNode);
    graph.addEdge(parentNode, deptNode);
    // Employees will be displayed inside the department card
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
          algorithm: SugiyamaAlgorithm(
            SugiyamaConfiguration()
              ..nodeSeparation = (50)
              ..levelSeparation = (100)
              ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM
              ..coordinateAssignment = CoordinateAssignment.Average,
          ),
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

    if (nodeId.startsWith('superior_')) {
      final parts = nodeId.split('_');
      final superiorId = int.parse(parts[1]);
      final roleId = int.parse(parts[2]);

      final superior = _findSuperiorById(structure, superiorId);
      final role = structure.roleStructure.firstWhere((r) => r.id == roleId);

      if (superior != null) {
        return _buildSuperiorNodeWidget(superior, role);
      }
    } else if (nodeId.startsWith('dept_')) {
      final deptId = int.parse(nodeId.split('_')[1]);
      final dept = _findDepartmentById(structure, deptId);
      if (dept != null) {
        return _buildDepartmentNodeWidget(dept);
      }
    }

    return _buildDefaultNode();
  }

  Widget _buildSuperiorNodeWidget(SuperiorEmployeeEntity superior, RoleStructureEntity role) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: AppColors.blue, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Role badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              role.userRole.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 12),
          // Employee photo
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(superior.employee.photoUrl),
            backgroundColor: Colors.grey.shade200,
          ),
          const SizedBox(height: 10),
          // Employee name
          SizedBox(
            width: 120,
            child: Text(
              superior.employee.fullname,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          // Employee NIK
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
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: AppColors.neutral4, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Department header
          Row(
            children: [
              const Icon(Icons.group_work, color: AppColors.blue, size: 18),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  dept.department.departmentName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: AppColors.blue,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (dept.employeeStructure.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Divider(height: 1, color: AppColors.neutral3),
            const SizedBox(height: 8),
            // Employee list
            ...dept.employeeStructure.map((emp) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(emp.employee.photoUrl),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            emp.employee.fullname,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            emp.employee.nik,
                            style: TextStyle(
                              fontSize: 9,
                              color: AppColors.neutral6,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
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
}
