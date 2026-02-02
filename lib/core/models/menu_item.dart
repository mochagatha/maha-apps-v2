/// Menu Item Model
/// Represents a menu item with its configuration
class MenuItem {
  final String code;
  final String name;
  final String? iconPath;
  final String? route;
  final bool isAsset;
  final List<MenuItem> children;

  const MenuItem({
    required this.code,
    required this.name,
    this.iconPath,
    this.route,
    this.isAsset = true,
    this.children = const [],
  });

  /// Check if menu has children
  bool get hasChildren => children.isNotEmpty;

  /// Get menu by code from children recursively
  MenuItem? findChildByCode(String code) {
    for (final child in children) {
      if (child.code == code) {
        return child;
      }
      final found = child.findChildByCode(code);
      if (found != null) {
        return found;
      }
    }
    return null;
  }

  /// Create a copy with updated properties
  MenuItem copyWith({
    String? code,
    String? name,
    String? iconPath,
    String? route,
    bool? isAsset,
    List<MenuItem>? children,
  }) {
    return MenuItem(
      code: code ?? this.code,
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      route: route ?? this.route,
      isAsset: isAsset ?? this.isAsset,
      children: children ?? this.children,
    );
  }

  @override
  String toString() {
    return 'MenuItem(code: $code, name: $name, route: $route, hasChildren: $hasChildren)';
  }
}
