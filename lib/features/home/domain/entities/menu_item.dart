import 'package:equatable/equatable.dart';

/// Domain entity representing a menu item in the application
/// Supports hierarchical structure with parent-child relationships
class MenuItem extends Equatable {
  final int id;
  final String name;
  final String code;
  final String label;
  final String icon;
  final bool isAsset;
  final int order;
  final List<MenuItem>? children;

  const MenuItem({
    required this.id,
    required this.name,
    required this.code,
    required this.label,
    required this.icon,
    required this.isAsset,
    required this.order,
    this.children,
  });

  /// Check if menu has children
  bool get hasChildren => children != null && children!.isNotEmpty;

  /// Find child menu by code recursively
  MenuItem? findChildByCode(String searchCode) {
    if (children == null) return null;
    
    for (final child in children!) {
      if (child.code == searchCode) {
        return child;
      }
      final found = child.findChildByCode(searchCode);
      if (found != null) return found;
    }
    return null;
  }

  @override
  List<Object?> get props => [id, name, code, label, icon, isAsset, order, children];
}
