// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/di/di.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/presentation/screens/todo_editing/widgets/deadline_editing_tile.dart';
import 'package:todo/presentation/screens/todo_editing/widgets/delete_todo_tile.dart';
import 'package:todo/presentation/screens/todo_editing/widgets/priority_editing_tile.dart';
import 'package:todo/presentation/screens/todo_editing/widgets/todo_editing_card.dart';
import 'package:todo/uikit/theme.dart';

void createTodo(BuildContext context) async {
  final todo = await showTodoEditingDialog(context);

  if (todo == null) return;
  if (!context.mounted) return;

  context.read<TodosBloc>().add(
        TodosEvent.add(todo),
      );
}

void editTodo(BuildContext context, Todo todo) async {
  final editedTodo = await showTodoEditingDialog(context, todo);

  if (editedTodo == null) return;
  if (!context.mounted) return;

  context.read<TodosBloc>().add(
        TodosEvent.update(editedTodo),
      );
}

Future<Todo?> showTodoEditingDialog(BuildContext context, [Todo? todo]) {
  return showDialog<Todo>(
    context: context,
    builder: (_) => BlocProvider(
      create: (_) => getIt.get<TodoEditingCubit>(param1: todo),
      child: const NewTaskDialogBody(),
    ),
  );
}

class NewTaskDialogBody extends StatelessWidget {
  const NewTaskDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoEditingCubit, TodoEditingState>(
      listener: (context, state) {
        state.whenOrNull(
          completed: Navigator.of(context).pop,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: ColorsUI.textPrimary,
            ),
            onPressed: Navigator.of(context).pop,
          ),
          actions: [
            TextButton(
              onPressed: context.read<TodoEditingCubit>().completeEditing,
              child: const Text(
                'СОХРАНИТЬ',
                style: TextStyle(
                  color: ColorsUI.blue,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            const TodoEditingCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  PriorityEditingTile(),
                  Divider(),
                  DeadlineEditingTile(),
                ],
              ),
            ),
            const Divider(),
            const DeleteTodoTile(),
          ],
        ),
      ),
    );
  }
}
