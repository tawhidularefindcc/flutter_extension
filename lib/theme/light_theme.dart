import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';

ThemeData light({Color color = AppColors.primaryTeal}) => ThemeData(
  fontFamily: 'Roboto',
  primaryColor: color,
  secondaryHeaderColor: AppColors.primarySky,
  disabledColor: const Color(0xFFBABFC4),
  scaffoldBackgroundColor: AppColors.backgroundLight,
  brightness: Brightness.light,
  hintColor: AppColors.hintColor,
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
  colorScheme: const ColorScheme.light(primary: AppColors.primaryTeal, secondary: AppColors.primarySky, surface: AppColors.backgroundLight, error: AppColors.red500),
  useMaterial3: true,
);