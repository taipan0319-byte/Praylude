import 'package:flutter/material.dart';

/// Praylude visual language, v0 — "warm candlelight."
/// Deliberately provisional: warm, hopeful, contemporary. The final
/// direction is an open design conversation; everything routes through
/// these tokens so a redesign is a one-file change.
class AppTheme {
  // Palette
  static const cream = Color(0xFFFAF5EC); // page background
  static const parchment = Color(0xFFF1E8D8); // cards
  static const ember = Color(0xFF9C3D2E); // primary — warm terracotta red
  static const candleGold = Color(0xFFC99A3C); // accents, streak flame
  static const ink = Color(0xFF3B3028); // primary text, warm near-black
  static const inkSoft = Color(0xFF7A6E62); // secondary text
  static const nightBlue = Color(0xFF2E3A4E); // novena / vigil accents

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ember,
        primary: ember,
        secondary: candleGold,
        surface: cream,
      ),
      scaffoldBackgroundColor: cream,
    );
    return base.copyWith(
      textTheme: base.textTheme.apply(bodyColor: ink, displayColor: ink),
      cardTheme: const CardThemeData(
        color: parchment,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: cream,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: true,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: ember,
          foregroundColor: cream,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
