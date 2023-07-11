import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/presentation/router/parser.dart';

void main() {
  late AppRouteInformationParser parser;

  setUp(() => parser = AppRouteInformationParser());
  parse(String? str) {
    return parser.parseRouteInformation(RouteInformation(location: str));
  }

  group('Если нет пути, выводить главную конфигураци', () {
    test('случай с ""', () async {
      final res = await parse('');
      expect(res.main, true);
    });
    test('случай с "/"', () async {
      final res = await parse('/');
      expect(res.main, true);
    });
    test('случай с null', () async {
      final res = await parse(null);
      expect(res.main, true);
    });
  });
}
