import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color.fromRGBO(233, 30, 33, 1);
  static const Color background = Color(0xfeFEFEFE);
  static const Color card = Color(0xfeF4F4F4);
  static const Color border = Color(0xfe000000);
  static const Color secondary = Color(0xff858585);
  static const Color third = Color.fromRGBO(248, 248, 248, 1);
  
  // Neutral
  static const Color neutral1 = Color(0xffF4F4F4);
  static const Color neutral2 = Color(0xffEDEDED);
  static const Color neutral3 = Color(0xffDEDEDE);
  static const Color neutral4 = Color(0xffBBBBBB);
  static const Color neutral5 = Color(0xff9C9C9C);
  static const Color neutral6 = Color(0xff737373);
  static const Color neutral7 = Color(0xff5F5F5F);
  static const Color neutral8 = Color(0xff404040);
  static const Color neutral9 = Color(0xff202020);
  
  // Text colors
  static const Color textPrimary = Color(0xff202020);
  
  // Error
  static const Color error = Color(0xffE91E21);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.background,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.neutral9,
        onError: Colors.white,
        outline: AppColors.border,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(),
      
      // ElevatedButton Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          disabledBackgroundColor: AppColors.secondary,
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.neutral3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.neutral3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: const TextStyle(color: AppColors.neutral5),
      ),
      
      // Card Theme
      cardTheme: const CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          side: BorderSide(color: AppColors.neutral2),
        ),
        margin: EdgeInsets.zero,
      ),
      
      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.neutral9),
        titleTextStyle: TextStyle(
          color: AppColors.neutral9,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
