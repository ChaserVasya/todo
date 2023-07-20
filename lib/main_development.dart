import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:todo/application/app.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/data/services/todo_synchronizer.dart';
import 'package:todo/utils/ui.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      settingUpSystemUIOverlay();
      await configureDependencies(Environment.dev);
      await getIt<TodoSynchronizer>().synchronize();
      runApp(const App());
    },
    (e, s) => getIt<Logger>().e(e, e, s),
  );
}
