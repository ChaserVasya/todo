import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/application/app.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/global.dart';
import 'package:todo/data/services/todo_synchronizer.dart';
import 'package:todo/utils/ui.dart';

Future<void> main(List<String> env) async {
  WidgetsFlutterBinding.ensureInitialized();
  settingUpSystemUIOverlay();
  final outerEnv = env.isNotEmpty ? env.single : null;
  logger.d('outerEnv: $outerEnv');
  await configureDependencies(outerEnv ?? Environment.prod);
  runZonedGuarded(
    () async {
      if (outerEnv != 'test') {
        await getIt<TodoSynchronizer>().synchronize();
      }
      runApp(const App());
    },
    (e, s) => logger.e(e, e, s),
  );
}
