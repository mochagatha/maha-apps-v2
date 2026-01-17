import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maha_apps_v2/widgets/colors.dart';

///AppBar default✓
class AwesomeAppBarWithButton extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final Widget? leading;
  final Widget? rightButton;
  final VoidCallback? onRightButtonPressed;
  final Color backgroundColor;
  final Color landingColor;
  final Color textColor;
  final bool worker;
  final bool employee;
  final bool isAppBar;
  final Function()? onTap;

  const AwesomeAppBarWithButton({
    super.key,
    required this.title,
    this.leading,
    this.rightButton,
    this.onRightButtonPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.landingColor = Colors.white,
    this.textColor = Colors.white,
    this.worker = false,
    this.employee = false,
    this.isAppBar = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:
          leading ??
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                // if (worker == true) {
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                //   Get.toNamed(
                //     Routes.requestApplyLoanScreen,
                //     arguments: {
                //       "title": "Pinjaman Pekerja Harian",
                //       "check_condision_int": 2,
                //     },
                //   );
                // } else if (employee == true) {
                //   Navigator.pop(context);
                //   Navigator.pop(context);
                //   Get.toNamed(
                //     Routes.requestApplyLoanScreen,
                //     arguments: {
                //       "title": "Pinjaman Pribadi",
                //       "check_condision_int": 1,
                //     },
                //   );
                // } else {
                //   if (onTap != null) {
                //     onTap!();
                //   }
                //   Navigator.pop(context);
                // }
              },
              child:
                  // !isAppBar
                  //     ?
                  Icon(Icons.arrow_back, color: landingColor, size: 24),
              // :
              // FaIcon(
              //     color: landingColor,
              //     size: 24.px,
              //     FontAwesomeIcons.circleChevronLeft,
              //   ),
            ),
          ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          // fontSize: 17.sp, // Responsive font size
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        // AppTextStyles.titleAppStyle(context).copyWith(color: textColor),
      ),
      centerTitle: true,
      actions: [
        if (rightButton != null)
          IconButton(icon: rightButton!, onPressed: onRightButtonPressed),
      ],
      toolbarHeight: 77,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(77);
}
