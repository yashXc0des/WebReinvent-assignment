import 'package:flutter/material.dart';

class AppTheme {
  static const primaryBlue = Color(0xFF007AFF);
  static const bgColor = Color(0xFFF5F5F7);
  static const textPrimary = Color(0xFF1D1D1F);
  static const cardColor = Colors.white;

  static final light = ThemeData(
    scaffoldBackgroundColor: bgColor,
    fontFamily: 'SF Pro Display',
    colorScheme: const ColorScheme.light(primary: primaryBlue),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w600, color: textPrimary),
      bodyLarge: TextStyle(fontSize: 14, color: textPrimary),
    ),
  );
}
