import 'package:flutter/cupertino.dart';
import 'package:todo/application/app.dart';
import 'package:todo/application/di/di.dart';

void main() {
  configureDependencies();
  runApp(const App());
}
