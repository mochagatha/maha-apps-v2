import '../../domain/entities/menu_item.dart';

class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required String id,
    required String name,
    required String label,
    required String icon,
    required bool isAsset,
    required int order,
  }) : super(
          id: id,
          name: name,
          label: label,
          icon: icon,
          isAsset: isAsset,
          order: order,
        );

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    // V1 response format has nested structure:
    // { "menu_application": { "id": xxx, "name": "xxx", ... }, "children": [...] }
    final menuApp = json['menu_application'] as Map<String, dynamic>?;
    
    if (menuApp != null) {
      // V1 format with nested menu_application
      return MenuItemModel(
        id: menuApp['id']?.toString() ?? '',
        name: menuApp['name'] ?? '',
        label: menuApp['label'] ?? menuApp['name'] ?? '',
        icon: menuApp['icon'] ?? '',
        isAsset: menuApp['is_asset'] ?? false,
        order: menuApp['order'] ?? 0,
      );
    } else {
      // Fallback to flat structure (if API changes)
      return MenuItemModel(
        id: json['id']?.toString() ?? '',
        name: json['name'] ?? '',
        label: json['label'] ?? '',
        icon: json['icon'] ?? '',
        isAsset: json['is_asset'] ?? false,
        order: json['order'] ?? 0,
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'label': label,
      'icon': icon,
      'is_asset': isAsset,
      'order': order,
    };
  }

  MenuItem toEntity() {
    return MenuItem(
      id: id,
      name: name,
      label: label,
      icon: icon,
      isAsset: isAsset,
      order: order,
    );
  }
}
