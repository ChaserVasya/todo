import 'package:flutter/material.dart';
import 'package:todo/application/routes.dart';
import 'package:todo/uikit/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
      initialRoute: Routes.main.path,
    );
  }
}
