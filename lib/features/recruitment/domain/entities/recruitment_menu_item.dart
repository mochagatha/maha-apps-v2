import 'package:equatable/equatable.dart';

class RecruitmentMenuItem extends Equatable {
  final String id;
  final String label;
  final String icon;
  final String? route;
  final int count;

  const RecruitmentMenuItem({
    required this.id,
    required this.label,
    required this.icon,
    this.route,
    this.count = 0,
  });

  @override
  List<Object?> get props => [id, label, icon, route, count];
}
