import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF340000);
  static const Color onPrimary = Color(0xFFEDE6E6);
  static const Color primaryContainer = Color(0xFF340000);
  static const Color onPrimaryContainer = Color(0xFFEDE6E6); //;
  static const Color primarySurface = Color(0xFFFAFAFA);
  static const Color secondarySurface = Color(0xFFF8EFEF);
  static const Color black = Color(0xFF2F0000);
  static const Color onSurface40 = Color(0xFF4E4444);
  static const Color disabled = Color(0xFFA8ADBD);
  static const Color background = Color(0xFFFFFCFC);
  static const Color lightColor = Color(0xFFFDDFA6);
  static const Color urlColor = Color(0xFF2E88D6);
  static const Color errorColor = Colors.red;
  static const Color successColor = Color(0xFF10C46E);
  static const Color warningColor = Color(0xFFAC9B07);
  static const Color alertColor = Color(0xFFAD0F0F);
  static const Color greyColor = Color(0xFFC4C4C4);
}

const scheme = ColorScheme.light(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    primaryContainer: AppColors.primaryContainer,
    surface: AppColors.primarySurface,
    onSurface: AppColors.black,
    outline: AppColors.primaryContainer);

const inputTheme = InputDecorationTheme(
  border:
      OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  errorStyle: TextStyle(
    fontWeight: FontWeight.bold,
    color: Color(0xFFAD0F0F),
  ),
);

const elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      backgroundColor: MaterialStatePropertyAll(AppColors.primary),
      overlayColor: MaterialStatePropertyAll(Color(0x7FAD0F0F))),
);

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      colorScheme: scheme,
      inputDecorationTheme: inputTheme,
      elevatedButtonTheme: elevatedButtonTheme,
      useMaterial3: true,
    );
  }
}
