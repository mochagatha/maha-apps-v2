import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String label;
  final String icon;
  final bool isAsset;
  final int order;

  const MenuItem({
    required this.id,
    required this.name,
    required this.label,
    required this.icon,
    required this.isAsset,
    required this.order,
  });

  @override
  List<Object?> get props => [id, name, label, icon, isAsset, order];
}
