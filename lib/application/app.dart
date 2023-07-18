import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/application/exceptions/handle_exceptions.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/blocs/importance_color_cubit.dart';
import 'package:todo/presentation/blocs/theme_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/router/delegate.dart';
import 'package:todo/presentation/router/parser.dart';
import 'package:todo/presentation/uikit/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<TodosBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ThemeCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<ImportanceColorCubit>(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, Brightness>(
        builder: (_, brightness) {
          return MaterialApp.router(
            theme: _chooseTheme(brightness),
            debugShowCheckedModeBanner: false,
            routerDelegate: getIt<AppRouterDelegate>(),
            routeInformationParser: getIt<AppRouteInformationParser>(),
            localizationsDelegates: const [
              L10n.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: L10n.delegate.supportedLocales,
            scaffoldMessengerKey: messengerKey,
          );
        },
      ),
    );
  }

  ThemeData _chooseTheme(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return darkTheme;
      case Brightness.light:
        return lightTheme;
    }
  }
}
