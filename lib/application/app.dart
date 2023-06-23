import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/exceptions/handle_exceptions.dart';
import 'package:todo/application/routes.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/uikit/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<TodosBloc>(),
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          L10n.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: L10n.delegate.supportedLocales,
        routes: routes,
        initialRoute: Routes.main.path,
        scaffoldMessengerKey: messengerKey,
      ),
    );
  }
}
