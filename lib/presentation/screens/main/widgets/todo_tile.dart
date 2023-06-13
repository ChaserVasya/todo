import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/blocs/todo_bloc/todo_bloc.dart';
import 'package:todo/uikit/theme.dart';
import 'package:todo/uikit/warning_icon.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMEd();
    final key = this.key ?? ObjectKey(todo);
    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) {},
        checkColor: ColorsUI.green,
      ),
      subtitle: todo.dateTime != null
          ? Text(formatter.format(todo.dateTime!)) //
          : const SizedBox.shrink(),
      trailing: const Icon(Icons.info_outline),
      title: Row(
        children: [
          _buildPriorityLabel(),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              todo.todo,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  Widget build2(BuildContext context) {
    final formatter = DateFormat.yMEd();
    final key = this.key ?? ObjectKey(todo);

    return Dismissible(
      key: key,
      direction: DismissDirection.startToEnd,
      background: const ColoredBox(color: ColorsUI.green),
      onDismissed: (_) => context.read<TodoBloc>().add(
            TodoEvent.update(todo.copyWith(completed: true)),
          ),
      child: Dismissible(
        key: key,
        direction: DismissDirection.endToStart,
        background: const ColoredBox(color: ColorsUI.red),
        onDismissed: (_) => context.read<TodoBloc>().add(
              TodoEvent.delete(todo),
            ),
        child: ListTile(
          leading: Checkbox(
            value: todo.completed,
            onChanged: (_) {},
            checkColor: ColorsUI.green,
          ),
          title: SizedBox(
            height: 50,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPriorityLabel(),
                Flexible(
                  child: Text(
                    // todo.todo,
                    'hello',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          subtitle: todo.dateTime != null
              ? Text(formatter.format(todo.dateTime!)) //
              : null,
          trailing: const Icon(Icons.info_outline),
        ),
      ),
    );
  }

  Widget _buildPriorityLabel() {
    switch (todo.priority) {
      case Priority.none:
        return const SizedBox.shrink();
      case Priority.low:
        return const WarningIcon();
      case Priority.high:
        return const Icon(
          Icons.arrow_downward_rounded,
          color: ColorsUI.gray,
        );
    }
  }
}
