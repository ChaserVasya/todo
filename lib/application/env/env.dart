import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'TOKEN')
  static String token = _Env.token;
}

// class _Env {
//   static const String token = '';
// }
