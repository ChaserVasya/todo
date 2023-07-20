import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/router/config.dart';
import 'package:todo/presentation/screens/main/main_screen.dart';
import 'package:todo/presentation/screens/todo_editing/todo_editing_dialog.dart';

@lazySingleton
class AppRouterDelegate extends RouterDelegate<AppConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppConfig> {
  AppConfig state = const AppConfig.main();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TodosBloc>(),
      child: Navigator(
        key: navigatorKey,
        pages: [
          if (state.main == true) //
            const MainScreen(),
          if (state.edit == true) //
            BlocProvider(
              create: (context) => getIt<TodoEditingCubit>(param1: state.todo),
              child: BlocListener<TodoEditingCubit, TodoEditingState>(
                listener: (context, blocState) {
                  blocState.whenOrNull(completed: (todo) {
                    final todosBloc = context.read<TodosBloc>();
                    if (todo.id == null) {
                      todosBloc.add(TodosEvent.add(todo));
                    } else {
                      todosBloc.add(TodosEvent.update(todo));
                    }
                  });
                },
                child: const NewTaskDialogBody(),
              ),
            ),
        ].map((e) => MaterialPage(child: e)).toList(),
        onPopPage: (route, result) {
          if (!route.didPop(result)) {
            return false;
          }
          state = const AppConfig.main();

          notifyListeners();
          return true;
        },
      ),
    );
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Future<void> setNewRoutePath(AppConfig configuration) async {
    state = configuration;
    notifyListeners();
  }
}
