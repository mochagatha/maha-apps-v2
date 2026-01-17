import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maha_apps_v2/widgets/colors.dart';

///Card default
final InputDecoration textInputDecoration = InputDecoration(
  labelText: '',
  hintText: '',
  floatingLabelBehavior: FloatingLabelBehavior.never,
  labelStyle: const TextStyle(color: Colors.grey),
  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
  border: const OutlineInputBorder(),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.grey, width: 0.7),
    borderRadius: BorderRadius.circular(5.0),
  ),
);

///Font default
class AppTextStyles {
  /// Body 4 - Regular 12px Neutral/7 (#5F5F5F)
  static final body4Regular = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5F5F5F),
  );

  /// Subtitle 4 - SemiBold 12px Info/5 (#106AE8)
  static final subtitle4Blue = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: const Color(0xff106AE8),
  );

  /// Subtitle 4 - SemiBold 12px Warning/7 (#B78805)
  static final subtitle4Warning = GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: const Color(0xffB78805),
  );

  /// Subtitle 3 - SemiBold 14px Neutral/8 (#404040)
  static final subtitle3SemiBold = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: const Color(0xff404040),
  );

  /// Caption - Regular 10px Neutral/7 (#5F5F5F)
  static final caption10Regular = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: const Color(0xff5F5F5F),
  );

  /// Title KPI - Bold 15px Black
  static final titleKpi = GoogleFonts.poppins(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );
  // static TextStyle titleAppStyle(BuildContext? context) {
  //   return GoogleFonts.poppins(
  //     fontSize: 17.sp, // Responsive font size
  //     fontWeight: FontWeight.w600,
  //     color: Colors.white,
  //   );
  // }

  static TextStyle headingthreeSemiBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w600,
      color: Color(0xff404040),
    );
  }

  static TextStyle headingthreeRegular(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w400,
      color: Color(0xff737373),
    );
  }

  static TextStyle headingTwoSemiBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w600,
      color: Color(0xff202020),
    );
  }

  static TextStyle headingTwoRegulerBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w400,
      color: Color(0xff202020),
    );
  }

  static TextStyle buttonBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle titleStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w600,
      color: const Color.fromARGB(255, 255, 255, 255),
    );
  }

  static TextStyle titleWhiteStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 16, // Responsive font size
      fontWeight: FontWeight.w600,
      color: const Color(0xff202020),
    );
  }

  static TextStyle titleTextFieldStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.w600,
      color: const Color(0xff404040),
    );
  }

  static TextStyle subtitleStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.w600,
      color: Colors.grey[700],
    );
  }

  static TextStyle bodyStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 12, // Responsive font size
      fontWeight: FontWeight.w400,
      color: const Color(0xff5F5F5F),
    );
  }

  static TextStyle bodyOneSemiBold(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 12, // Responsive font size
      fontWeight: FontWeight.w600,
      color: const Color(0xff404040),
    );
  }

  static TextStyle costume12w700() {
    return GoogleFonts.poppins(
      fontSize: 12, // Responsive font size
      fontWeight: FontWeight.w700,
      color: const Color(0xff404040),
    );
  }

  static TextStyle bodyTwoReguler() {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.w400,
      color: const Color(0xff404040),
    );
  }

  static TextStyle bodyOneReguler() {
    return GoogleFonts.poppins(
      fontSize: 12, // Responsive font size
      fontWeight: FontWeight.w400,
      color: const Color(0xff999999),
    );
  }

  static TextStyle body() {
    return GoogleFonts.poppins(
      fontSize: 12, // Responsive font size
    );
  }

  static TextStyle bodyThreeReguler(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 10, // Responsive font size
      fontWeight: FontWeight.w400,
      color: const Color(0xff5F5F5F),
    );
  }

  static TextStyle subtitleTwoSemiBold() {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.w600,
      color: const Color(0xff404040),
    );
  }

  static TextStyle subtitle() {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
    );
  }

  static TextStyle captionStyle() {
    return GoogleFonts.poppins(
      fontSize: 10, // Responsive font size
      fontWeight: FontWeight.w300,
      color: Colors.grey[600],
    );
  }

  static TextStyle caption() {
    return GoogleFonts.poppins(
      fontSize: 10, // Responsive font size
    );
  }

  static TextStyle titleBigStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 20, // Responsive font size
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );
  }

  static TextStyle titleNormalStyle(BuildContext? context) {
    return GoogleFonts.poppins(
      fontSize: 14, // Responsive font size
      fontWeight: FontWeight.normal,
      color: Colors.black,
    );
  }

  //   static TextStyle otpStyle(BuildContext? context) {
  //   return GoogleFonts.poppins(
  //     fontSize: responsiveFontSize(context, .0), // Responsive font size
  //     fontWeight: FontWeight.normal,
  //     color: Colors.black,
  //   );
  // }
}
