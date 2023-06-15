import 'package:flutter/material.dart';
import 'package:todo/presentation/screens/todo_editing/todo_editing_dialog.dart';
import 'package:todo/uikit/theme.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () => createTodo(context),
        icon: const Icon(
          Icons.add,
        ),
      ),
      title: const Text(
        'Новое',
        style: TextStyle(color: ColorsUI.textTertiary),
      ),
    );
  }
}
