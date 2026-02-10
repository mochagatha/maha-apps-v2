import 'package:equatable/equatable.dart';

/// Configuration for a settings menu item
/// Contains all necessary information for display and navigation
class SettingsMenuConfig extends Equatable {
  /// Menu code identifier (e.g., "PENGATURAN/ABSENSI")
  final String code;

  /// L10n key for the menu title (e.g., "settingsAbsensi")
  final String titleKey;

  /// Path to the icon asset
  final String iconPath;

  /// Route path for navigation
  final String? routePath;

  /// Whether this menu requires special handling (e.g., language dialog)
  final bool hasCustomAction;

  /// Display order in the list
  final int order;

  const SettingsMenuConfig({
    required this.code,
    required this.titleKey,
    required this.iconPath,
    this.routePath,
    this.hasCustomAction = false,
    this.order = 0,
  });

  @override
  List<Object?> get props => [
    code,
    titleKey,
    iconPath,
    routePath,
    hasCustomAction,
    order,
  ];
}
