import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ColorsUI {
  static const red = Color(0xFFFF3B30);
  static const green = Color(0xFF34C759);
  static const blue = Color(0xFF007AFF);
  static const gray = Color(0xFF8E8E93);
  static const grayLight = Color(0xFFD1D1D6);
  static const white = Colors.white;
  static const black = Colors.black;
  static const textPrimary = Color(0xFF000000);
  static const textSecondary = Color(0x99000000);
  static const textTertiary = Color(0x4D000000);
}

final darkTheme = ThemeData(
  colorScheme: _darkColorScheme,
  textTheme: _textTheme,
  dividerTheme: const DividerThemeData(
    color: Color(0x33FFFFFF),
  ),
  scaffoldBackgroundColor: _darkColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: _darkColorScheme.background,
    systemOverlayStyle: _systemInterfaceWithIconColor(Brightness.light),
    iconTheme: const IconThemeData(
      color: ColorsUI.textTertiary,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _darkColorScheme.primary,
  ),
);

final lightTheme = ThemeData(
  colorScheme: _lightColorScheme,
  textTheme: _textTheme,
  dividerTheme: const DividerThemeData(
    color: Color(0x33000000),
  ),
  scaffoldBackgroundColor: _lightColorScheme.background,
  appBarTheme: AppBarTheme(
    backgroundColor: _lightColorScheme.background,
    systemOverlayStyle: _systemInterfaceWithIconColor(Brightness.dark),
    iconTheme: const IconThemeData(
      color: ColorsUI.textTertiary,
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: _lightColorScheme.primary,
  ),
);

SystemUiOverlayStyle _systemInterfaceWithIconColor(Brightness brightness) {
  return SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: brightness,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
    systemNavigationBarIconBrightness: brightness,
  );
}

const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: ColorsUI.blue,
  onPrimary: ColorsUI.white,
  secondary: ColorsUI.blue,
  onSecondary: ColorsUI.white,
  surface: ColorsUI.white,
  onSurface: Colors.black,
  error: ColorsUI.red,
  onError: ColorsUI.white,
  background: Color(0xFFF7F6F2),
  onBackground: ColorsUI.white,
);

const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // primary: Color(0xFF161618),
  primary: ColorsUI.blue,
  onPrimary: ColorsUI.white,
  secondary: Color(0xFF252528),
  onSecondary: ColorsUI.white,
  surface: ColorsUI.black,
  onSurface: ColorsUI.white,
  error: ColorsUI.red,
  onError: ColorsUI.white,
  background: Color(0xFF161618),
  onBackground: ColorsUI.white,
);

const _textTheme = TextTheme(
  titleLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
  labelLarge: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
  ),
  bodyMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  ),
  labelMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
  ),
);
