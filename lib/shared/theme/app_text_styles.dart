import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle headingTwoSemiBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: const Color(0xff202020),
    );
  }

  static TextStyle bodyStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xff5F5F5F),
    );
  }

  static TextStyle headingthreeRegular(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: const Color(0xff737373),
    );
  }
}
