import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo/presentation/screens/main/widgets/add_todo_tile.dart';
import 'package:todo/presentation/screens/main/widgets/todo_tile.dart';
import 'package:todo/uikit/helpers.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
      body: BlocProvider(
        create: (_) => getIt.get<TodoBloc>(),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) => state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            main: (todos) => CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Мои дела',
                          style: tth(context).labelLarge,
                        ),
                        Text(
                          'Выполнено - ${todos.map((e) => e.completed).count((e) => e)}',
                        )
                      ],
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility),
                    )
                  ],
                ),
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
}
