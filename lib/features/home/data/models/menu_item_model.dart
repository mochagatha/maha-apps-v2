import '../../domain/entities/menu_item.dart';

/// Data model for menu item that extends the domain entity
/// Handles JSON serialization/deserialization for hierarchical menu structure
class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.code,
    required super.label,
    required super.icon,
    required super.isAsset,
    required super.order,
    super.children,
  });

  /// Create model from JSON for hierarchical menu structure
  /// Supports both nested menu_application format and flat structure
  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    // Parse children recursively if present
    final childrenJson = json['children'] as List<dynamic>?;
    final List<MenuItemModel>? children = childrenJson
        ?.map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    // V1 response format has nested structure:
    // { "menu_application": { "id": xxx, "name": "xxx", "code": "xxx" }, "children": [...] }
    final menuApp = json['menu_application'] as Map<String, dynamic>?;

    if (menuApp != null) {
      // V1 format with nested menu_application
      return MenuItemModel(
        id: menuApp['id'] as int? ?? 0,
        name: menuApp['name'] as String? ?? '',
        code: menuApp['code'] as String? ?? '',
        label: menuApp['label'] as String? ?? menuApp['name'] as String? ?? '',
        icon: menuApp['icon'] as String? ?? '',
        isAsset: menuApp['is_asset'] as bool? ?? false,
        order: menuApp['order'] as int? ?? 0,
        children: children,
      );
    } else {
      // Fallback to flat structure (if API changes)
      return MenuItemModel(
        id: json['id'] as int? ?? 0,
        name: json['name'] as String? ?? '',
        code: json['code'] as String? ?? '',
        label: json['label'] as String? ?? json['name'] as String? ?? '',
        icon: json['icon'] as String? ?? '',
        isAsset: json['is_asset'] as bool? ?? false,
        order: json['order'] as int? ?? 0,
        children: children,
      );
    }
  }

  /// Convert model to JSON including children
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'label': label,
      'icon': icon,
      'is_asset': isAsset,
      'order': order,
      if (children != null)
        'children': children!.map((e) => (e as MenuItemModel).toJson()).toList(),
    };
  }

  /// Convert model to entity
  MenuItem toEntity() {
    return MenuItem(
      id: id,
      name: name,
      code: code,
      label: label,
      icon: icon,
      isAsset: isAsset,
      order: order,
      children: children,
    );
  }
}
