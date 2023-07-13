import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/router/config.dart';
import 'package:todo/presentation/router/delegate.dart';
import 'package:todo/presentation/screens/main/widgets/add_todo_tile.dart';
import 'package:todo/presentation/screens/main/widgets/todo_tile.dart';
import 'package:todo/presentation/uikit/helpers.dart';
import 'package:todo/presentation/uikit/theme.dart';
import 'package:todo/utils/extensions.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: () {
        final state = context.watch<TodosBloc>().state;
        return state.map<Widget?>(
          loading: (_) => null,
          main: (_) => Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () => AppRouterDelegate.of(context)
                    .setNewRoutePath(const AppConfig.edit()),
                child: const Icon(Icons.add),
              ),
              FloatingActionButton(
                onPressed: () =>
                    context.read<TodosBloc>().add(const TodosEvent.refresh()),
                child: const Icon(Icons.refresh),
              ),
            ].separateBy(const SizedBox(height: 10)),
          ),
        );
      }(),
      resizeToAvoidBottomInset: true,
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) => state.when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          main: (todos, shouldFilter) {
            if (shouldFilter) {
              todos = todos.filter((e) => !e.completed).toList();
            }
            return CustomScrollView(
              slivers: [
                _createMainAppBar(context, todos, shouldFilter),
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
            );
          },
        ),
      ),
    );
  }

  SliverAppBar _createMainAppBar(
    BuildContext context,
    List<Todo> todos,
    bool completedAreFiltered,
  ) {
    final l10n = L10n.of(context);
    const maxHeight = 160.0;

    return SliverAppBar(
      pinned: true,
      expandedHeight: maxHeight,
      collapsedHeight: 65,
      flexibleSpace: FlexibleSpaceBar(
        title: LayoutBuilder(builder: (context, constrains) {
          final notExpanded = maxHeight - 10 < constrains.maxHeight;
          return Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    l10n.main_title,
                    style: tth(context).labelLarge,
                  ),
                  if (!notExpanded) const SizedBox(height: 10),
                  if (notExpanded && !completedAreFiltered)
                    Text(
                      l10n.main_subtitle(todos.count((e) => e.completed)),
                      style: tth(context).bodyMedium!.copyWith(
                            color: ColorsUI.textTertiary,
                          ),
                    ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      context.read<TodosBloc>().add(
                            TodosEvent.filter(
                              shouldFilter: !completedAreFiltered,
                            ),
                          );
                    },
                    color: ColorsUI.blue,
                    icon: Icon(
                      completedAreFiltered
                          ? Icons.visibility //
                          : Icons.visibility_off,
                    ),
                  ),
                ],
              )
            ],
          );
        }),
      ),
    );
  }
}
