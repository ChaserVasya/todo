import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/screens/main/widgets/add_todo_tile.dart';
import 'package:todo/presentation/screens/main/widgets/todo_tile.dart';
import 'package:todo/presentation/screens/todo_editing/todo_editing_dialog.dart';
import 'package:todo/uikit/helpers.dart';
import 'package:todo/uikit/theme.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => createTodo(context),
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => getIt.get<TodosBloc>(),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) => state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(),
            ),
            main: (todos, completedAreFiltered) => CustomScrollView(
              slivers: [
                _createMainAppBar(context, todos, completedAreFiltered),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Card(
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          for (final todo in todos)
                            TodoTile(todo, key: ObjectKey(todo.id)),
                          const AddTodoTile(),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverAppBar _createMainAppBar(
    BuildContext context,
    List<Todo> todos,
    bool completedAreFiltered,
  ) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 160.0,
      flexibleSpace: FlexibleSpaceBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Мои дела',
              style: tth(context).labelLarge,
            ),
            Text(
              'Выполнено - ${todos.map((e) => e.completed).count((e) => e)}',
              style: tth(context).bodyMedium!.copyWith(
                    color: ColorsUI.textTertiary,
                  ),
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            context.read<TodosBloc>().add(
                  TodosEvent.filter(
                    shouldFilter: !completedAreFiltered,
                  ),
                );
          },
          icon: Icon(
            completedAreFiltered
                ? Icons.visibility //
                : Icons.visibility_off,
          ),
        )
      ],
    );
  }
}
