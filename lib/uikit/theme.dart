import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo/application/app.dart';

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

const textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  ),
  labelLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  ),
);

final theme = ThemeData(
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  dividerTheme: const DividerThemeData(
    color: Color(0x33000000),
  ),
  scaffoldBackgroundColor: const Color(0xFFF7F6F2),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  ),
);
