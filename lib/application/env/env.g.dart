// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

class _Env {
  static const List<int> _enviedkeytoken = [
    581907333,
    685753984,
    4112859787,
    1355226632,
    2720956274,
    2020833108,
    343877126,
    1260845886
  ];
  static const List<int> _envieddatatoken = [
    581907436,
    685754098,
    4112859876,
    1355226726,
    2720956165,
    2020833083,
    343877236,
    1260845898
  ];
  static final String token = String.fromCharCodes(
    List.generate(_envieddatatoken.length, (i) => i, growable: false)
        .map((i) => _envieddatatoken[i] ^ _enviedkeytoken[i])
        .toList(growable: false),
  );
}
