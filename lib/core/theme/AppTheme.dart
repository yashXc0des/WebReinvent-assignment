import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFF5F5F7),
  cardColor: Colors.white,
  primaryColor: const Color(0xFF007AFF),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Color(0xFF1D1D1F)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
  ),
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1C1C1E),
  cardColor: const Color(0xFF2C2C2E),
  primaryColor: const Color(0xFF0A84FF),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF2C2C2E),
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
  ),
);
