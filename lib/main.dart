import 'package:flutter/cupertino.dart';
import 'package:todo/application/app.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/exceptions/handle_exceptions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  handleExceptions();
  runApp(const App());
}
