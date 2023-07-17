// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

class _Env {
  static const List<int> _enviedkeytoken = [
    1667391891,
    670597767,
    386989330,
    3294324038,
    2812474660,
    2135441072,
    1774645641,
    3038265715
  ];
  static const List<int> _envieddatatoken = [
    1667391994,
    670597877,
    386989437,
    3294324008,
    2812474707,
    2135441119,
    1774645755,
    3038265607
  ];
  static final String token = String.fromCharCodes(
    List.generate(_envieddatatoken.length, (i) => i, growable: false)
        .map((i) => _envieddatatoken[i] ^ _enviedkeytoken[i])
        .toList(growable: false),
  );
}
