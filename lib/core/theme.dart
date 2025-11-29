import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: const Color(0xFF007AFF),
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'System',
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.black87),
    headlineMedium: TextStyle(fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF007AFF),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(vertical: 16),
    ),
  ),
);