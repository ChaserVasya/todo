import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/application/app.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/services/todo_synchronizer.dart';
import 'package:todo/utils/ui.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  settingUpSystemUIOverlay();
  await configureDependencies(Environment.prod);
  runZonedGuarded(
    () async {
      await getIt<TodoSynchronizer>().synchronize();
      runApp(const App());
    },
    (e, s) => logger.e(e, e, s),
  );
}
