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
    return MenuItemModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      label: json['label'] ?? '',
      icon: json['icon'] ?? '',
      isAsset: json['is_asset'] ?? false,
      order: json['order'] ?? 0,
    );
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
