import '../../domain/entities/menu_access_entity.dart';

/// Data model for menu access that extends the domain entity
/// Handles JSON serialization/deserialization
class MenuAccessModel extends MenuAccessEntity {
  const MenuAccessModel({
    required super.id,
    required super.name,
    required super.code,
    super.children,
  });

  /// Create model from JSON for employee menus
  /// Employee menus are nested under "menu_application" key
  factory MenuAccessModel.fromJson(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List?;

    return MenuAccessModel(
      id: json['menu_application']['id'] as int,
      name: json['menu_application']['name'] as String,
      code: json['menu_application']['code'] as String,
      children: childrenJson
          ?.map((e) => MenuAccessModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Create model from JSON for all menus
  /// All menus have direct structure without nesting
  factory MenuAccessModel.fromJsonAllMenus(Map<String, dynamic> json) {
    final childrenJson = json['children'] as List?;

    return MenuAccessModel(
      id: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      children: childrenJson
          ?.map((e) =>
              MenuAccessModel.fromJsonAllMenus(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      if (children != null)
        'children': children!
            .map((e) => (e as MenuAccessModel).toJson())
            .toList(),
    };
  }
}
