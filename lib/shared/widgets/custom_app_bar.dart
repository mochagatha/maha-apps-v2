import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

/// Reusable AppBar widget for all menu/submenu pages (except home)
///
/// Features:
/// - Red background color (AppColors.primary)
/// - White text and icons (foregroundColor)
/// - Optional back button (automatically shown when there's a previous route)
/// - Centered title
/// - Support for custom actions
/// - Customizable height (default 77px to match v1 design)
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text displayed in the AppBar
  final String title;

  /// Optional custom leading widget
  /// If null and showBackButton is true, a default back button will be shown
  final Widget? leading;

  /// Whether to show the back button automatically
  /// Default is true - will show back button if there's a previous route
  final bool showBackButton;

  /// Optional actions to display on the right side of the AppBar
  final List<Widget>? actions;

  /// Height of the AppBar (default 77px to match v1 design)
  final double height;

  /// Whether to center the title (default true)
  final bool centerTitle;
  final Color backgroundColor;
  final Color foregroundColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.showBackButton = true,
    this.actions,
    this.height = 77,
    this.centerTitle = true,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: showBackButton,
      leading:
          leading ??
          (showBackButton
              ? IconButton(
                  icon: const FaIcon(
                    FontAwesomeIcons.circleChevronLeft,
                    size: 24,
                  ),
                  tooltip: 'Back',
                  onPressed: () => Navigator.pop(context),
                )
              : null),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: foregroundColor,
        ),
      ),
      centerTitle: centerTitle,
      toolbarHeight: height,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: foregroundColor),
      actionsIconTheme: IconThemeData(color: foregroundColor),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
