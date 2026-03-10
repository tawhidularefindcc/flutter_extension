import 'dart:ui';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryTeal = Color(0xFF24A79E);
  static const Color primarySky = Color(0xFF1B59A6);
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color darkNavy = Color(0xFF0F172A);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate500 = Color(0xFF64748B);
  static const Color green500 = Color(0xFF22C55E);
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color amber500 = Color(0xFFF59E0B);
  static const Color red500 = Color(0xFFEF4444);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.bottomRight,
    colors: [primarySky, primaryTeal],
  );

  static Color primaryColor = primaryTeal;
  static Color markedSecondaryColor = primarySky;
  static Color accentColor = slate500;
  static Color deepAccentColor = slate800;
  static Color backgroundColor = backgroundLight;
  static Color cardColor = Colors.white;
  static Color cardLightColor = const Color(0xFFF1F5F9);
  static Color borderColor = const Color(0xFFE2E8F0);
  static Color textColor = slate800;
  static Color subTextColor = slate500;
  static Color hintColor = const Color(0xFF94A3B8);
  static Color greyColor = const Color(0xFFCBD5E1);
  static Color fillColor = const Color(0xFFF1F5F9);
  static Color dividerColor = const Color(0xFFE2E8F0);
  static Color shadowColor = const Color(0x0F000000);

  static BoxShadow shadow = BoxShadow(
    blurRadius: 10,
    spreadRadius: 0,
    color: shadowColor,
    offset: const Offset(0, 4),
  );
}
