import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/todo_editing_cubit/todo_editing_cubit.dart';
import 'package:todo/presentation/widgets/priority_icon.dart';
import 'package:todo/uikit/theme.dart';

class PriorityEditingTile extends StatelessWidget {
  const PriorityEditingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          for (final priority in Priority.values)
            PopupMenuItem(
              child: _priorityWidget(priority),
              onTap: () {
                context.read<TodoEditingCubit>().editPriority(priority);
              },
            ),
        ];
      },
      child: ListTile(
        title: const Text('Важность'),
        subtitle: BlocSelector<TodoEditingCubit, TodoEditingState, Priority>(
          selector: (state) => state.map(
            editing: (state) => state.priority,
            completed: (state) => state.todo.priority,
          ),
          builder: (context, priority) {
            return _priorityWidget(priority);
          },
        ),
      ),
    );
  }

  Widget _priorityWidget(Priority priority) {
    switch (priority) {
      case Priority.none:
        return const Text('Нет');
      case Priority.low:
        return const Text('Низкий');
      case Priority.high:
        return Row(children: [
          PriorityIcon(priority),
          const Text(
            'Высокий',
            style: TextStyle(color: ColorsUI.red),
          ),
        ]);
    }
  }
}
