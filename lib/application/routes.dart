import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/main/main_screen.dart';

enum Routes {
  main('/main');

  const Routes(this.path);

  final String path;
}

final routes = () {
  final pageByRoute = {
    Routes.main: MainScreen.new,
  };

  return {
    for (final pair in pageByRoute.entries) //
      pair.key.path: (BuildContext _) => pair.value(),
  };
}();
