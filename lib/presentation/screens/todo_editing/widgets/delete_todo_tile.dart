import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/blocs/todos_bloc/todos_bloc.dart';
import 'package:todo/uikit/helpers.dart';
import 'package:todo/uikit/theme.dart';

class DeleteTodoTile extends StatelessWidget {
  const DeleteTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocSelector<TodoEditingCubit, TodoEditingState, int?>(
        selector: _getIdFromState,
        builder: (context, id) {
          final alreadyCreated = id != null;
          return IconButton(
            color: ColorsUI.red,
            icon: Row(
              children: [
                const Icon(Icons.delete),
                Text(
                  ln(context).todo_editing_delete,
                  style: TextStyle(
                    color: alreadyCreated
                        ? ColorsUI.red //
                        : ColorsUI.textTertiary,
                  ),
                ),
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
      ),
    );
  }

  int? _getIdFromState(TodoEditingState state) {
    return state.map(
      editing: (state) => state.id,
      completed: (state) => state.todo.id,
    );
  }
}
