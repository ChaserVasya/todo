import 'package:flutter/material.dart';
import 'package:todo/domain/models/todo.dart';
import 'package:todo/presentation/widgets/priority_icon.dart';
import 'package:todo/uikit/date_time_text.dart';
import 'package:todo/uikit/helpers.dart';
import 'package:todo/uikit/theme.dart';
import 'package:todo/utils/extensions.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(this.todo, {required Key key}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: TodoCompletedCheckBox(todo),
      subtitle: todo.dateTime != null
          ? DateTimeText(todo.dateTime!) //
          : null,
      trailing: const Icon(Icons.info_outline),
      title: Row(
        children: <Widget>[
          if (todo.priority != Priority.none) PriorityIcon(todo.priority),
          Flexible(
            child: Text(
              todo.todo,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ].separateBy(const SizedBox(width: 10)),
      ),
    );
  }
}

class TodoCompletedCheckBox extends StatelessWidget {
  const TodoCompletedCheckBox(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: todo.completed,
      onChanged: (_) {},
      checkColor: ColorsUI.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2),
      ),
      side: BorderSide(
        color: th(context).dividerTheme.color!,
        width: 2,
      ),
    );
  }
}
