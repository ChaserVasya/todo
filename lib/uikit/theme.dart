import 'package:flutter/material.dart';

abstract class ColorsUI {
  static const red = Color(0xFFFF3B30);
  static const green = Color(0xFF34C759);
  static const blue = Color(0xFF007AFF);
  static const gray = Color(0xFF8E8E93);
  static const grayLight = Color(0xFFD1D1D6);
  static const white = Colors.white;
  static const black = Colors.black;
}

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFF7F6F2),
  onPrimary: Colors.black,
  secondary: ColorsUI.white,
  onSecondary: Colors.black,
  surface: ColorsUI.white,
  onSurface: Colors.black,
  error: ColorsUI.red,
  onError: ColorsUI.white,
  background: Color(0xFFF7F6F2),
  onBackground: ColorsUI.white,
);

final theme = ThemeData(
  colorScheme: lightColorScheme,
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      height: 38,
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: TextStyle(
      height: 32,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: TextStyle(
      height: 14,
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      height: 20,
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    labelMedium: TextStyle(
      height: 20,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  ),
);
