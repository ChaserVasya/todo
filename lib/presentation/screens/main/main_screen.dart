import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo/presentation/screens/main/widgets/todo_tile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => getIt.get<TodoBloc>(),
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) => state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            main: (todos) => CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar(
                  pinned: true,
                  expandedHeight: 160.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('SliverAppBar'),
                    background: FlutterLogo(),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: todos.length,
                    (context, i) => TodoTile(todos[i]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
