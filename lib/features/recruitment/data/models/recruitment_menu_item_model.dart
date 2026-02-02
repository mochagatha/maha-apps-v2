import '../../domain/entities/recruitment_menu_item.dart';

class RecruitmentMenuItemModel extends RecruitmentMenuItem {
  const RecruitmentMenuItemModel({
    required super.id,
    required super.label,
    required super.icon,
    super.route,
    super.count,
  });

  factory RecruitmentMenuItemModel.fromJson(Map<String, dynamic> json) {
    return RecruitmentMenuItemModel(
      id: json['id'] as String,
      label: json['label'] as String,
      icon: json['icon'] as String,
      route: json['route'] as String?,
      count: json['count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'icon': icon,
      'route': route,
      'count': count,
    };
  }

  RecruitmentMenuItem toEntity() {
    return RecruitmentMenuItem(
      id: id,
      label: label,
      icon: icon,
      route: route,
      count: count,
    );
  }
}
