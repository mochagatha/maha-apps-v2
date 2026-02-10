import 'package:equatable/equatable.dart';

/// Domain entity representing a menu item in the application
/// Supports hierarchical structure with parent-child relationships
class MenuAccessEntity extends Equatable {
  final int id;
  final String name;
  final String code;
  final List<MenuAccessEntity>? children;

  const MenuAccessEntity({
    required this.id,
    required this.name,
    required this.code,
    this.children,
  });

  @override
  List<Object?> get props => [id, name, code, children];
}
