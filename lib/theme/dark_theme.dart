import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

ThemeData dark({Color color = AppColors.primaryTeal}) => ThemeData(
  fontFamily: 'Roboto',
  primaryColor: color,
  secondaryHeaderColor: AppColors.primarySky,
  disabledColor: const Color(0xffa2a7ad),
  scaffoldBackgroundColor: AppColors.darkNavy,
  brightness: Brightness.dark,
  hintColor: AppColors.hintColor,
  cardColor: const Color(0xFF1E293B), // Slate 800ish
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)), 
  colorScheme: const ColorScheme.dark(primary: AppColors.primaryTeal, secondary: AppColors.primarySky, surface: Color(0xFF1E293B), error: AppColors.red500),
  useMaterial3: true,
);