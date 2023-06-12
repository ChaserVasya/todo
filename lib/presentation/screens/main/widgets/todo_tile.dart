import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/uikit/theme.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile(this.todo, {super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMEd();

    return ListTile(
      leading: Checkbox(
        value: todo.completed,
        onChanged: (_) {},
        checkColor: ColorsUI.green,
      ),
      title: Row(children: [
        _buildPriorityLabel(),
        Text(
          todo.todo,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
      ]),
      subtitle: todo.dateTime != null
          ? Text(formatter.format(todo.dateTime!)) //
          : null,
      trailing: const Icon(Icons.info_outline),
    );
  }

  Widget _buildPriorityLabel() {
    switch (todo.priority) {
      case Priority.none:
        return const SizedBox.shrink();
      case Priority.low:
        const priorityHighIcon = Icon(
          Icons.priority_high_rounded,
          color: ColorsUI.red,
        );
        return Row(children: const [
          priorityHighIcon,
          priorityHighIcon,
        ]);
      case Priority.high:
        return const Icon(
          Icons.arrow_downward_rounded,
          color: ColorsUI.gray,
        );
    }
  }
}
