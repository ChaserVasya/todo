import 'package:flutter/material.dart';

class AddTodoTile extends StatelessWidget {
  const AddTodoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      title: const Text('Новое'),
    );
  }
}
