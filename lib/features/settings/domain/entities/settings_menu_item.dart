import 'package:equatable/equatable.dart';

/// Domain entity representing a settings menu item
class SettingsMenuItem extends Equatable {
  /// Menu code identifier (e.g., "PENGATURAN/PENEMPATAN_KERJA")
  final String id;

  /// Path to the menu icon asset
  final String icon;

  /// Display text for the menu item
  final String text;

  /// Badge count for notifications (0 means no badge)
  final int count;

  /// Route path for navigation
  final String? route;

  const SettingsMenuItem({
    required this.id,
    required this.icon,
    required this.text,
    this.count = 0,
    this.route,
  });

  @override
  List<Object?> get props => [id, icon, text, count, route];
}
