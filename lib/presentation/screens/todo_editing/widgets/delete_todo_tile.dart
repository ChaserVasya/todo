import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/uikit/theme.dart';

class DeleteTodoTile extends StatelessWidget {
  const DeleteTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodoEditingCubit, TodoEditingState, int?>(
      selector: _getIdFromState,
      builder: (context, id) {
        final alreadyCreated = id != null;
        return IconButton(
          color: ColorsUI.red,
          icon: Row(
            children: const [
              Icon(Icons.delete),
              Text('Удалить'),
            ],
          ),
          onPressed: alreadyCreated
              ? () {
                  context.read<TodosBloc>().add(
                        TodosEvent.delete(id),
                      );
                  Navigator.of(context).pop();
                }
              : null,
        );
      },
    );
  }

  int? _getIdFromState(TodoEditingState state) {
    return state.map(
      editing: (state) => state.id,
      completed: (state) => state.todo.id,
    );
  }
}
