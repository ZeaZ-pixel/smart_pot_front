import 'package:flutter/material.dart';
import 'package:smart_pot_front/config/themes/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    fontFamily: 'IBM Plex Sans',
    scaffoldBackgroundColor: AppColors.secondary,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        minimumSize: const Size(double.infinity, 60),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: AppColors.secondary,
          width: 1,
        ),
        foregroundColor: AppColors.secondary,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        minimumSize: const Size(double.infinity, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}
