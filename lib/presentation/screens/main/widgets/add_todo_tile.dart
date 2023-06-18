import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/presentation/screens/todo_editing/todo_editing_dialog.dart';
import 'package:todo/uikit/theme.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: IconButton(
          onPressed: () => createTodo(context),
          icon: const Icon(Icons.add),
        ),
        title: Text(
          L10n.of(context).todo_new,
          style: const TextStyle(color: ColorsUI.textTertiary),
        ),
      ),
    );
  }
}
