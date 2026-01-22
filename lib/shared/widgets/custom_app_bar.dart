import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

/// Custom AppBar widget matching v1 design pattern
///
/// Features:
/// - Red background color (AppColors.primary)
/// - Height of 77px
/// - Centered white title text
/// - Back button with circular chevron icon
/// - Supports custom leading widget
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title text displayed in the center of the AppBar
  final String title;

  /// Optional custom leading widget
  /// If null, a default back button with circular chevron icon will be used
  final Widget? leading;

  const CustomAppBar({super.key, required this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
          leading ??
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.circleChevronLeft,
              color: Colors.white,
              size: 24,
            ),
            tooltip: 'Back',
            onPressed: () => Navigator.maybePop(context),
          ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 77,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(77);
}
