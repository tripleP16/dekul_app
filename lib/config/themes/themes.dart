import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF340000);
  static const Color onPrimary = Color(0xFFEDE6E6);
  static const Color primaryContainer = Color(0xFF340000);
  static const Color onPrimaryContainer = Color(0xFFEDE6E6); //;
  static const Color primarySurface = Color(0xFFFAFAFA);
  static const Color secondarySurface = Color(0xFFF8EFEF);
  static const Color onSurface20 = Color(0xFF2F0000);
  static const Color onSurface40 = Color(0xFF4E4444);
  static const Color onSurface60 = Color(0xFFA8ADBD);
  static const Color background = Color(0xFFFFFCFC);
}

const lightScheme = ColorScheme.light(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.onPrimary,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  primaryContainer: AppColors.primaryContainer,
  background: AppColors.background,
  surface: AppColors.primarySurface,
  onSurface: AppColors.onSurface20,
  outline: AppColors.primaryContainer
);

class AppTheme {
  ThemeData getTheme() {
    return ThemeData(
      colorScheme: lightScheme,

      useMaterial3: true,
    );
  }
}

