import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/routes.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/uikit/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<TodosBloc>(),
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        routes: routes,
        initialRoute: Routes.main.path,
      ),
    );
  }
}
