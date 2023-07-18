// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'env.dart';

// **************************************************************************
// EnviedGenerator
// **************************************************************************

class _Env {
  static const List<int> _enviedkeytoken = [
    2712154258,
    2829577281,
    3059457622,
    4086418831,
    4151536755,
    960282157,
    3521662875,
    2338299778
  ];
  static const List<int> _envieddatatoken = [
    2712154363,
    2829577267,
    3059457593,
    4086418913,
    4151536644,
    960282178,
    3521662953,
    2338299894
  ];
  static final String token = String.fromCharCodes(
    List.generate(_envieddatatoken.length, (i) => i, growable: false)
        .map((i) => _envieddatatoken[i] ^ _enviedkeytoken[i])
        .toList(growable: false),
  );
}
