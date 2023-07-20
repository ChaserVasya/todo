import 'dart:io';

import 'package:dio/dio.dart';
import 'package:todo/application/env/env.dart';

Dio createYandexClient() {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://beta.mrdekk.ru/todobackend',
      connectTimeout: const Duration(seconds: 10),
      headers: {
        'Authorization': 'Bearer ${Env.token}',
      },
    ),
  );

  HttpOverrides.global = _HttpPassAllCerts();

  return dio;
}

class _HttpPassAllCerts extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (_, __, ___) => true;
  }
}
