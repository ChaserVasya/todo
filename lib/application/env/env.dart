import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'TOKEN')
  static const String token = _Env.token;
}

// class _Env {
//   static const String token = '';
// }
